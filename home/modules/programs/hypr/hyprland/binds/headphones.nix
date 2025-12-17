{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, B, exec, ${pkgs.headphones}/bin/headphones"
    ];
  };
}
