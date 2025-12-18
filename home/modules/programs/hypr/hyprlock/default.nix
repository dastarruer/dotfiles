<<<<<<< HEAD:home/modules/programs/hyprland/hyprlock.nix
{
  pkgs,
  config,
  ...
}: {
=======
{pkgs, ...}: {
  imports = [
    ./pfp.nix
    ./password-input.nix
    ./date.nix
    ./battery-status.nix
    ./background.nix
  ];

>>>>>>> master:home/modules/programs/hypr/hyprlock/default.nix
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

  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Custom_systemd_units
  systemd.user.services.hyprlock = {
    Unit = {
      Description = "Lock the screen before sleep";
      Before = ["sleep.target"];
    };

    Install = {
      WantedBy = ["sleep.target"];
    };

    Service = {
      Type = "forking";
      User = "%I";
      Environment = "DISPLAY=:0";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
      ExecStartPost = "${pkgs.coreutils}/bin/sleep 1";
    };
  };
}
