{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.window-manager.hypr.hypridle.enable = lib.mkEnableOption "Enable hypridle.";
  };

  config = lib.mkIf config.home-manager.window-manager.hypr.hypridle.enable {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 180;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend || loginctl suspend";
          }
        ];
      };
    };
  };
}
