{config, ...}: let
  waybarDotfilesDir = "${config.home.homeDirectory}/.dotfiles/home/programs/waybar";
  waybarConfigDir = "${config.home.homeDirectory}/.config/waybar";
in {
  # Old waybar comes from here: https://github.com/bibjaw99/workstation/tree/master/.config/waybar_block
  # New one from here: https://github.com/saatvik333/hyprland-dotfiles/blob/main/waybar/config
  imports = [
    ./colors.nix
  ];

  programs.waybar = {
    enable = true;
  };

  # Symlink the files instead of using home manager (for my own sanity)
  home.file."${waybarConfigDir}".source = config.lib.file.mkOutOfStoreSymlink "${waybarDotfilesDir}/config/waybar";

  # Waybar rules that are recommended by the hyprland wiki
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur,waybar"
      "xray 0,waybar"
      "ignorezero,waybar"
    ];
  };
}
