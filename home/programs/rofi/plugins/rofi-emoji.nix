{pkgs, ...}: {
  programs.rofi.plugins = [
    pkgs.rofi-emoji-wayland
  ];

  # Hyprland keybinds
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, A, exec, rofi -modi emoji -show emoji"
  ];
}
