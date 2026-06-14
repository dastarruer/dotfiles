{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    wallpaper-daemon = config.custom.wm.wallpaper-daemon;

    theme = config.custom.theme.name;
    wallpaperDir = "${inputs.self.outPath}/config/wallpapers/${theme}";

    colors = config.lib.stylix.colors;
  in
    lib.mkIf (wallpaper-daemon == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
        {
          assertion = bar == "noctalia";
          message = "noctalia wallpaper daemon only works after enabling the noctalia bar.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.noctalia.settings.wallpaper = with colors.withHashtag; {
          enabled = true;
          fill_color = base00;
          transition = ["wipe"];
          transition_on_startup = true;
          directory = wallpaperDir;
        };
      };
    };
}
