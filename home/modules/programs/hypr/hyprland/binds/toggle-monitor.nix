{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, Y, exec, ${pkgs.toggle-hdmi}/bin/toggle-HDMI-A-1"
      "SUPER+SHIFT, Y, exec, ${pkgs.toggle-laptop}/bin/toggle-eDP-1"
    ];
  };
}
