{...}: {
  # Old waybar comes from here: https://github.com/bibjaw99/workstation/tree/master/.config/waybar_block
  # New one from here: https://github.com/saatvik333/hyprland-dotfiles/blob/main/waybar/config
  imports = [
    ./config.nix
    ./style.nix
  ];

  programs.waybar = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur,waybar"
      "xray 0,waybar"
      "ignorezero,waybar"
    ];
  };
}
