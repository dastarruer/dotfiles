{...}: {
  wayland.windowManager.hyprland.settings = {
    # Monitor setup
    monitor = [
      # Main monitor in middle
      "HDMI-A-1, 1920x1080@144, 0x0, 1"

      # Laptop monitor on the right
      "eDP-1, 1920x1080@60, 1920x0, 1"
    ];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
  };
}
