{config, ...}: {
  programs.mpv.enable = true;

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile = {
    "mpv/mpv.conf".enable = false;
  };

  # Symlink the rofi config
  home.file.".config/mpv/mpv.conf" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/mpv/mpv.conf";
    recursive = true;
  };
}
