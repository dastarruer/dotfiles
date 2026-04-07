{...}: {
  flake.nixosModules.wm = {
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      script = pkgs.writeShellApplication {
        name = "battery-status";
        runtimeInputs = [pkgs.coreutils];
        text = ''
          status="$(cat /sys/class/power_supply/BAT0/status)"
          level="$(cat /sys/class/power_supply/BAT0/capacity)"

          if [[ "$status" == "Discharging" || "$status" == "Full" ]]; then
            if [[ "$level" -eq 0 ]]; then
              echo "$level% "
            elif [[ "$level" -ge 1 && "$level" -le 25 ]]; then
              echo "$level% "
            elif [[ "$level" -ge 26 && "$level" -le 50 ]]; then
              echo "$level% "
            elif [[ "$level" -ge 51 && "$level" -le 75 ]]; then
              echo "$level% "
            elif [[ "$level" -ge 76 && "$level" -le 100 ]]; then
              echo "$level% "
            fi
          elif [[ "$status" == "Charging" ]]; then
            echo "$level% "
          fi
        '';
      };
    in {
      programs.hyprlock.settings.label = [
        {
          monitor = "";
          text = ''
            cmd[update:1000] echo "$(${lib.getExe script})"
          '';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 15;
          font_family = "JetBrains Mono Nerd Font Propo";
          position = "-25, 512";
          halign = "right";
          valign = "center";
        }
      ];
    };
  };
}
