{...}: {
  flake.nixosModules.wm = {config, ...}: {
    home-manager.users.dastarruer = {
      programs.hyprlock.settings = {
        general = {
          immediate_render = true;
        };

        background = [
          {
            monitor = "";
            path = "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/wallpaper";
            color = "rgba(25, 20, 20, 1.0)";
            blur_passes = 2;
            blur_size = 2;
          }
        ];
      };
    };
  };
}
