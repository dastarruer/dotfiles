# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./theme.nix
    ./plugins
  ];

  programs.rofi = {
    enable = true;

    # Specify rofi-wayland because wayland
    package = pkgs.rofi-wayland;
  };

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile."rofi/config.rasi".enable = false;

  # Symlink the rofi config
  home.file.".config/rofi" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/rofi";
    recursive = true;
  };
}
