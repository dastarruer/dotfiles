# Waybar from here: https://github.com/saatvik333/hyprland-dotfiles/blob/main/waybar/config
{config, ...}: {
  imports = [
    ./colors.nix
  ];

  programs.waybar.enable = true;

  # Symlink the entire Waybar directory
  home.file.".config/waybar" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/waybar";
  };
}
