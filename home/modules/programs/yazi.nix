{
  pkgs,
  config,
  ...
}: {
  programs.yazi = {
    enable = true;
  };

  # Dependencies
  home.packages = with pkgs; [
    dragon-drop # Drag and drop functionality
  ];

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile."yazi/keymap.toml".enable = false;

  # Symlink keybinds
  home.file.".config/yazi/keymap.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/config/yazi/keymap.toml";
}
