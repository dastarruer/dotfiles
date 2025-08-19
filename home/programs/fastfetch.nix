{config, ...}: {
  programs.fastfetch = {
    enable = true;
  };

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile = {
    "fastfetch/config.jsonc".enable = false;
  };

  # Symlink fastfetch config
  home.file.".config/fastfetch" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/fastfetch";
    recursive = true;
  };
}
