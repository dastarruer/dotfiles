{pkgs, ...}: {
  programs.rofi.plugins = [
    pkgs.rofi-emoji
  ];

  wayland.windowManager.hyprland.settings = {
    "bind" = [
      "SUPER, A, exec, rofi -modi emoji -show emoji"
    ];
  };
}
