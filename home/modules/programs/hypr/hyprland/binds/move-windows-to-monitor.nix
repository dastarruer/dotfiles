{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, K, exec, ${pkgs.move-windows-to-monitor}/bin/move-windows-to-monitor"
    ];
  };
}
