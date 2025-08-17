{...}: {
  services.hypridle = {
    enable = true;
  };

  # Symlink hypridle
  # home.file = {
  #   ".config/hypr/hypridle.config" = {
  #     source =
  #       config.lib.file.mkOutOfStoreSymlink
  #       "${config.home.homeDirectory}/.dotfiles/config/hypr/hypridle.conf";
  #   };
  # };
}
