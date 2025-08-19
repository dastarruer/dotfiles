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

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];
  };

  # Hyprland packages needed
  home.packages = with pkgs; [
    waybar
    swww

    # Network manager
    networkmanagerapplet
  ];

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile = {
    "hypr/hyprland.conf".enable = false;
    "hypr/hypridle.conf".enable = false;
    "hypr/hyprlock.conf".enable = false;
  };

  # Symlink hyprland config
  home.file.".config/hypr" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/hypr";
    recursive = true;
  };
}
