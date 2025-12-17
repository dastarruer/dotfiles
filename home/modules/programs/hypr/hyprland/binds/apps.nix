{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, O, exec, ${pkgs.apps}/bin/apps"
    ];
  };
}
