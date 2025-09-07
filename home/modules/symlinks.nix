{
  config,
  lib,
  ...
}: {
  # Symlink a bunch of files
  home.file = {
    # $HOME files
    "bin" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/config/bin";

      # Set every script to executable
      # executable = true;
    };
    ".bashrc" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/config/bashrc/.bashrc";
    };
    "Pictures/wallpapers" = {
      source = lib.mkDefault (
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/config/wallpapers/gruvbox"
      );
    };
  };

  specialisation.catppuccin.configuration.home.file."Pictures/wallpapers".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/config/wallpapers/catppuccin";
}
