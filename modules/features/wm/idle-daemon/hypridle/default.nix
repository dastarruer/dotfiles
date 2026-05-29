{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
    wayland = config.custom.wm.wayland;
    idle-daemon = config.custom.wm.idle-daemon;
  in
    lib.mkIf (idle-daemon == "hypridle") {
      assertions = [
        {
          assertion = wayland;
          message = "hypridle only works on Wayland compositors.";
        }
      ];

      home-manager.users.dastarruer = {
        services.hypridle = {
          enable = true;

          settings.general = {
            # Pause all players and lock screen
            before_sleep_cmd = "${lib.getExe pkgs.pause-all} && ${pkgs.systemd}/bin/loginctl lock-session";
            after_sleep_cmd =
              lib.mkIf hyprland
              ''${pkgs.hyprland}/bin/hyprctl dispatch "hl.dsp.dpms(on)"'';

            # Inhibit sleep until screen is locked; prevents lockscreen from dying (hopefully)
            inhibit_sleep = 2;
          };
        };
      };
    };
}
