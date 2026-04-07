{...}: {
  flake.nixosModules.hardware = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.wayland.windowManager.hyprland;
  in {
    hardware.brillo.enable = true;

    # Backlight access
    users.users.dastarruer.extraGroups = ["video"];

    # Custom script to handle brightness based on which monitor is focused
    nixpkgs.overlays = [
      (final: prev: {
        brightness = prev.writeShellApplication {
          name = "brightness";

          runtimeInputs = with prev; [
            brillo
            coreutils
          ];

          text = ''
            set +e

            usage="Usage: $0 [+|-] [brightness]"

            if [ "$#" -ne 2 ]; then
                echo "No direction/brightness parameter provided"
                echo "$usage"
                exit 1
            fi

            arg="$1"
            brightness="$2"

            if [ "$arg" == "help" ] || [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
                echo "$usage"
                exit 0
            fi

            if [ "$arg" != "+" ] && [ "$arg" != "-" ]; then
                echo "Direction parameter must be '+' or '-'"
                echo "$usage"
                exit 1
            fi

            direction=$arg

            # Fallback to eDP-1 if Hyprland is not enabled or detection fails
            focused_name="eDP-1"
            ${lib.optionalString hyprland.enable ''
              if monitor_data=$(${pkgs.hyprland}/bin/hyprctl monitors -j 2>/dev/null); then
                  focused_name=$(echo "$monitor_data" | ${lib.getExe pkgs.jq} -r '.[] | select(.focused == true) | .name')
              fi
            ''}

            if [ "$focused_name" != "eDP-1" ]; then
                if [ "$direction" == "-" ]; then
                    brillo -s ddcci7 -U "$brightness" -q
                else
                    brillo -s ddcci7 -A "$brightness" -q
                fi
            else
                if [ "$direction" == "-" ]; then
                    brillo -s amdgpu_bl1 -U "$brightness" -q
                else
                    brillo -s amdgpu_bl1 -A "$brightness" -q
                fi
            fi
          '';
        };
      })
    ];

    # Control external monitor brightness with keyboard
    # Doesn't work when the monitor is plugged in through my usb hub (so basically doesn't work for my use case...)
    # Allow ddcci-driver to be used kernels > 6.8
    # nixpkgs.overlays = [
    #   (self: super: {
    #     linuxPackages_latest = super.linuxPackages_latest.extend (lpself: lpsuper: {
    #       ddcci-driver = super.linuxPackages_latest.ddcci-driver.overrideAttrs (oldAttrs: {
    #         version = super.linuxPackages_latest.ddcci-driver.version + "-FIXED";
    #         src = pkgs.fetchFromGitLab {
    #           owner = "ddcci-driver-linux";
    #           repo = "ddcci-driver-linux";
    #           rev = "0233e1ee5eddb4b8a706464f3097bad5620b65f4";
    #           hash = "sha256-Osvojt8UE+cenOuMoSY+T+sODTAAKkvY/XmBa5bQX88=";
    #         };
    #         patches = [
    #           (pkgs.fetchpatch {
    #             name = "ddcci-e0605c9cdff7bf3fe9587434614473ba8b7e5f63.patch";
    #             url = "https://gitlab.com/nullbytepl/ddcci-driver-linux/-/commit/e0605c9cdff7bf3fe9587434614473ba8b7e5f63.patch";
    #             hash = "sha256-sTq03HtWQBd7Wy4o1XbdmMjXQE2dG+1jajx4HtwBHjM=";
    #           })
    #         ];
    #       });
    #     });
    #   })
    # ];

    # boot.extraModulePackages = with config.boot.kernelPackages; [ddcci-driver];

    # boot.kernelModules = ["ddcci-backlight"];

    # services.udev.extraRules = let
    #   bash = "${pkgs.bash}/bin/bash";
    #   ddcciDev = "AMDGPU DM i2c hw bus 1";
    #   ddcciNode = "/sys/bus/i2c/devices/i2c-7/new_device";
    # in ''
    #   SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    # '';

    # Alternate way of doing the same thing
    # https://wiki.nixos.org/wiki/Backlight#Via_ddcutil
    # this way i have to manually use the ddcutil command but it's faster so yk
    # hardware.i2c.enable = true;
    # environment.systemPackages = [pkgs.ddcutil];

    # # Give user access to monitor brightness control
    # users.users.dastarruer.extraGroups = ["ic2"];
  };
}
