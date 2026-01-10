# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  imports = [
    ./theme.nix
    ./config.nix
    ./plugins
  ];

  options = {
    home-manager.window-manager.rofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable rofi, an app launcher.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.rofi.enable {
    programs.rofi = {
      enable = true;
    };

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      bind = [
        "SUPER, D, exec, rofi -show drun"
      ];

      layerrule = [
        "blur on, match:namespace rofi"
        "xray on, match:namespace rofi"
      ];
    };
  };
}
