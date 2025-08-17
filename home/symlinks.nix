{config, ...}: let
  currentTheme = "gruvbox";
in {
  # Symlink a bunch of files
  home.file = {
    # $HOME files
    "bin" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/config/bin";

      # Set every script to executable
      executable = true;
    };
    ".bashrc" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/config/bashrc/.bashrc";
    };
    "Pictures/wallpapers" = {
      source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/config/wallpapers/${currentTheme}";
    };
  };
}
# UNUSED
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
# .config files
# ".config/hypr" = {
#   source =
#     config.lib.file.mkOutOfStoreSymlink
#     "${config.home.homeDirectory}/.dotfiles/hypr";
# };
# ".config/kitty" = {
#   source =
#     config.lib.file.mkOutOfStoreSymlink
#     "${config.home.homeDirectory}/.dotfiles/kitty";
# };
# ".config/neofetch" = {
#   source =
#     config.lib.file.mkOutOfStoreSymlink
#     "${config.home.homeDirectory}/.dotfiles/neofetch";
# };
# ".config/wal" = {
#   source =
#     config.lib.file.mkOutOfStoreSymlink
#     "${config.home.homeDirectory}/.dotfiles/pywal";
# };
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
# ".config/waybar" = {
#   source =
#     config.lib.file.mkOutOfStoreSymlink
#     "${config.home.homeDirectory}/.dotfiles/waybar";
# };
# ".config/yazi" = {
#   source =
#     config.lib.file.mkOutOfStoreSymlink
#     "${config.home.homeDirectory}/.dotfiles/yazi";
# };

