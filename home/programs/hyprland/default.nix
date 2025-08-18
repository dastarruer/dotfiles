{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # set to the flake package for more up to date software
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # For stuff between apps like clipboard access, drag and drop, etc.
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hyprland packages needed
  home.packages = with pkgs; [
    waybar
    swww

    # Network manager
    networkmanagerapplet
  ];

  # Symlink hyprland config
  home.file.".config/hypr" = {
    source = "${config.home.homeDirectory}/.dotfiles/config/hypr";

    # Copy every file in the dir
    recursive = true;
  };
}
