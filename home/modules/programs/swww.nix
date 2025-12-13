{...}: {
  services.swww.enable = true;

  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      # Start swww daemon on startup
      "swww-daemon &"
    ];
  };
}
