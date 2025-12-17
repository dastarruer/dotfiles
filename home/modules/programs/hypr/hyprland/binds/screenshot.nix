{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      ",Print, exec, ${pkgs.screenshot}/bin/screenshot"
    ];
  };
}
