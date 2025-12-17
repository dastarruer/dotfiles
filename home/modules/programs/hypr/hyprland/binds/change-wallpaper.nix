{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER+SHIFT, W, exec, ${pkgs.change-wallpaper}/bin/change-wallpaper"
    ];
  };
}
