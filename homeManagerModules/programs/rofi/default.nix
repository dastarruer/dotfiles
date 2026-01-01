# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{...}: {
  imports = [
    ./theme.nix
    ./config.nix
    ./plugins
  ];

  programs.rofi = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, D, exec, rofi -show drun"
    ];

    layerrule = [
      "blur, rofi"
      "xray 0, rofi"
      "ignorezero, rofi"
    ];
  };
}
