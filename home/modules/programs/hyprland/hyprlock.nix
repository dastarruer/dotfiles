{
  pkgs,
  config,
  ...
}: {
  # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
  programs.hyprlock = {
    enable = true;
    settings = {
      # This links hyprlock's theme to Ax-Shell's dynamic colors
      source = config.programs.ax-shell.hyprlandColorsConfPath;

      background = {
        path = config.programs.ax-shell.currentWallpaperPath;
      };
    };
  };

  systemd.user.services.hyprlock = {
    Unit = {
      Description = "Lock screen with hyprlock before suspend";
      Before = ["sleep.target"];
    };

    Service = {
      Type = "forking";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
    };

    Install = {
      WantedBy = ["sleep.target"];
    };
  };
}
