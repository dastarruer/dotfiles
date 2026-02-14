{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.window-manager.hypridle;
  hyprlock = config.home-manager.window-manager.hyprlock;
  hyprland = config.home-manager.window-manager.hyprland;
in {
  options = {
    home-manager.window-manager.hypridle.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable hypridle.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;

      # These settings will lock the screen before suspend
      settings.general = {
        lock_cmd =
          lib.mkIf hyprlock.enable
          "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock && sleep 0.1";

        before_sleep_cmd = "${lib.getExe pkgs.pause-all} && ${pkgs.systemd}/bin/loginctl lock-session";
        after_sleep_cmd =
          lib.mkIf hyprland.enable
          "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      };
    };
  };
}
