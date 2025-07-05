{config, ...}: {
  # Symlink a bunch of files
  home.file = {
    # $HOME files
    "bin" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/bin";
    };
    ".bashrc" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/bashrc/.bashrc";
    };
    # ".gitconfig" = {
    #   source =
    #     config.lib.file.mkOutOfStoreSymlink
    #     "${config.home.homeDirectory}/.dotfiles/gitconfig/.gitconfig";
    # };
    # ".gitignore_global" = {
    #   source =
    #     config.lib.file.mkOutOfStoreSymlink
    #     "${config.home.homeDirectory}/.dotfiles/gitconfig/.gitignore_global";
    # };
    "Pictures/wallpapers" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/wallpapers";
    };

    # .config files
    ".config/hypr" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/hypr";
    };
    # ".config/kitty" = {
    #   source =
    #     config.lib.file.mkOutOfStoreSymlink
    #     "${config.home.homeDirectory}/.dotfiles/kitty";
    # };
    ".config/neofetch" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/neofetch";
    };
    ".config/wal" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/pywal";
    };
    # ".config/rofi" = {
    #   source =
    #     config.lib.file.mkOutOfStoreSymlink
    #     "${config.home.homeDirectory}/.dotfiles/rofi";
    # };
    # ".config/starship" = {
    #   source =
    #     config.lib.file.mkOutOfStoreSymlink
    #     "${config.home.homeDirectory}/.dotfiles/starship";
    # };
    ".config/waybar" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/waybar";
    };
    ".config/yazi" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/yazi";
    };
  };
}
