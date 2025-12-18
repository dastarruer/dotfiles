{...}: {
  programs.hyprlock.settings = {
    general = {
      immediate_render = true;
    };

    background = [
      {
        monitor = "";
        path = "/home/dastarruer/Pictures/wallpaper";
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 2;
        blur_size = 2;
      }
    ];
  };
}
