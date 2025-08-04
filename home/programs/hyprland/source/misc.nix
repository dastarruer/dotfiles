{...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = ["eDP-1,1920x1080@60.00Hz,0x0,1"];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];

    misc = {
      # Lower amount of frames sent when nothing is happening
      vfr = true;
    };

    master.new_status = "master";
  };
}
