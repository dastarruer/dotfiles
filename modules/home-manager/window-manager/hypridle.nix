{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.window-manager.hypridle;
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

      settings.general = {
        # Pause all players and lock screen
        before_sleep_cmd = "${lib.getExe pkgs.pause-all} && ${pkgs.systemd}/bin/loginctl lock-session";
        after_sleep_cmd =
          lib.mkIf hyprland.enable
          "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      };
    };
  };
}
