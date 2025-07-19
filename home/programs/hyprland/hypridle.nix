{...}: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "hyprlock"; # lock before suspend.
      };

      listener = [
        {
          # Turn off screen
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          # Suspend system
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
