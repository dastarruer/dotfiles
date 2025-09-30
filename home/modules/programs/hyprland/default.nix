{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.caelestia-shell.homeManagerModules.default

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

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [];
    };
    settings = {
      bar.status = {
        showBattery = false;
      };
      paths.wallpaperDir = "~/Images";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
