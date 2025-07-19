{...}: {
  services.hypridle = {
    enable = true;

    settings = {
      listener = [
        {
          timeout = 600;
          on-timeout = "hyprlock && systemctl suspend";
        }
        {
          timeout = 300;
          on-timeout = "hyprlock && hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
