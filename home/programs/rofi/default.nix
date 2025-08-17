{pkgs, ...}: {
  imports = [
    ./config.nix
    ./plugins
  ];

  programs.rofi = {
    enable = true;

    # Specify rofi-wayland because wayland
    package = pkgs.rofi-wayland;
  };

  # Hyprland keybinds
  # wayland.windowManager.hyprland.settings = {
  #   bind = [
  #     "$mainMod, D, exec, rofi -show drun"
  #   ];
  # };
}
