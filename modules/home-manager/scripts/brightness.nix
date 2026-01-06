{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
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
}
