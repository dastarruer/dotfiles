{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, P, exec, ${pkgs.kill-apps}/bin/kill-apps"
    ];
  };
}
