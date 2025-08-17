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

  # Waybar rules that are recommended by the hyprland wiki
  # wayland.windowManager.hyprland.settings = {
  #   layerrule = [
  #     "blur,waybar"
  #     "xray 0,waybar"
  #     "ignorezero,waybar"
  #   ];
  # };
}
