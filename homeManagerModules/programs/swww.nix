{...}: {
  services.swww.enable = true;

  # Start swww daemon on startup
  wayland.windowManager.hyprland.settings."exec-once" = [
    "swww-daemon &"
  ];
}
