{config, ...}: {
  programs.hyprlock.settings = {
    general = {
      immediate_render = true;
    };

    background = [
      {
        monitor = "";
        path = "${config.home.homeDirectory}/Pictures/wallpaper";
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 2;
        blur_size = 2;
      }
    ];
  };
}
