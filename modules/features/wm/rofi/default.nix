# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
      stylix.targets.rofi.enable = false;

      programs.rofi = {
        enable = true;
        location = "top";
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
  };
}
