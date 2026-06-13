{...}: {
  flake.nixosModules.hardware = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    hardware.brillo.enable = true;

    users.users.dastarruer.extraGroups = [
      "video" # Backlight access
      "i2c" # ddcutil access
    ];

    # Control external monitor backlight
    # https://wiki.nixos.org/wiki/Backlight#Via_ddcutil
    boot.kernelModules = ["i2c-dev"];
    services.udev.extraRules = ''
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';
    
    # Custom script to handle brightness based on which monitor is focused
    nixpkgs.overlays = [
      (final: prev: {
        brightness = prev.writeShellApplication {
          name = "brightness";

          runtimeInputs = with prev; [
            brillo
            coreutils
          ];

          text = let
            # Build a shell case statement from monitors that have a backlight device
            cases =
              lib.concatMapStringsSep "\n" (
                m:
                  lib.optionalString (m.backlightDevice != null) ''
                    "${m.name}")
                        if [ "$direction" == "-" ]; then
                            brillo -s ${m.backlightDevice} -U "$brightness" -q
                        else
                            brillo -s ${m.backlightDevice} -A "$brightness" -q
                        fi
                        ;;
                  ''
              )
              config.custom.hardware.monitors;

            # Pick the first monitor with a backlight as the fallback
            fallback = lib.findFirst (m: m.backlightDevice != null) null config.custom.hardware.monitors;
            fallbackName =
              if fallback != null
              then fallback.name
              else "eDP-1";
          in ''
            set +e

            usage="Usage: $0 [+|-] [brightness]"

            if [ "$#" -ne 2 ]; then
                echo "No direction/brightness parameter provided"
                echo "$usage"
                exit 1
            fi

            arg="$1"
            brightness="$2"

            case "$arg" in
              help|--help|-h) echo "$usage"; exit 0 ;;
              +|-) direction=$arg ;;
              *)
                echo "Direction parameter must be '+' or '-'"
                echo "$usage"
                exit 1
                ;;
            esac

            focused_name="${fallbackName}"
            ${lib.optionalString hyprland ''
              if monitor_data=$(${pkgs.hyprland}/bin/hyprctl monitors -j 2>/dev/null); then
                  focused_name=$(echo "$monitor_data" | ${lib.getExe pkgs.jq} -r '.[] | select(.focused == true) | .name')
              fi
            ''}

            case "$focused_name" in
            ${cases}
              *)
                  echo "No backlight device configured for monitor: $focused_name"
                  exit 1
                  ;;
            esac
          '';
        };
      })
    ];

  };
}
