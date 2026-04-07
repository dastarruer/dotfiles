{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
      services.hypridle = {
        enable = true;

        settings.general = {
          # Pause all players and lock screen
          before_sleep_cmd = "${lib.getExe pkgs.pause-all} && ${pkgs.systemd}/bin/loginctl lock-session";
          after_sleep_cmd =
            lib.mkIf hyprland.enable
            "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        };
      };
    };
  };
}
