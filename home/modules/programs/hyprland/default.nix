{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hyprlock.nix
    # ./hypridle.nix
    ./hyprsunset.nix
    ./colors.nix
    # ./plugins.nix
  ];

  # Allows GUI apps to run sudo on wayland basically
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # set to the flake package for more up to date software
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # For stuff between apps like clipboard access, drag and drop, etc.
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  home = {
    # Hyprland packages needed
    packages = with pkgs; [
      waybar
      swww
      jq
      socat

      # Network manager
      networkmanagerapplet
    ];

    # This line does not do anything, so this env variable is declared in config.fish
    # sessionVariables.NIXOS_OZONE_WL = "1";
  };

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
