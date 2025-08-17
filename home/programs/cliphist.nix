{pkgs, ...}: {
  home.packages = with pkgs; [
    cliphist
  ];

  # Cliphist keybinds
  # wayland.windowManager.hyprland.settings.bind = [
  #   # Note that this requires rofi
  #   "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
  # ];
}
