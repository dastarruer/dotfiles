{...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [",preferred,auto,1"];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];

    master.new_status = "master";
  };
}
