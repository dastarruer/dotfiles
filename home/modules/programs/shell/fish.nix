{config, ...}: {
  # Enable fish shell
  programs.fish = {
    enable = true;
  };

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile."fish/config.fish".enable = false;

  # Symlink fish config
  home.file.".config/fish/config.fish".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/config/fish/config.fish";
}
