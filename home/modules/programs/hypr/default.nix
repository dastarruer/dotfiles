{config, ...}: {
  imports = [
    ./hyprland
    # ./hypridle.nix
    ./hyprlock.nix
    ./hyprsunset.nix
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
