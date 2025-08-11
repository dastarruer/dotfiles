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

  # Symlink the files
  home.file = {
    "${waybarConfigDir}/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${waybarDotfilesDir}/config.jsonc";

    "${waybarConfigDir}/style.css".source = config.lib.file.mkOutOfStoreSymlink "${waybarDotfilesDir}/style.css";
  };

  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur,waybar"
      "xray 0,waybar"
      "ignorezero,waybar"
    ];
  };
}
