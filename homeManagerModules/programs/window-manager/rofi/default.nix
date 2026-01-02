# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{
  config,
  lib,
  ...
}: {
  imports = [
    ./theme.nix
    ./config.nix
    ./plugins
  ];

  options = {
    dotfiles.window-manager.rofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable rofi, an app launcher.";
    };
  };

  config = lib.mkIf config.dotfiles.window-manager.rofi.enable {
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
  };
}
