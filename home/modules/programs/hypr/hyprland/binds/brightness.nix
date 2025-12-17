{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "ALT, B, exec, ${pkgs.brightness}/bin/brightness + 5"
      "ALT, V, exec, ${pkgs.brightness}/bin/brightness - 5"
    ];
  };
}
