# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      hyprland = hmConfig.wayland.windowManager.hyprland;
      launcher = config.custom.wm.launcher;
    in
      lib.mkIf (launcher == "rofi") {
        stylix.targets.rofi.enable = false;

        programs.rofi = {
          enable = true;
          location = "top";
        };

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
          bind = [
            {_args = ["SUPER + D" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofi} -show drun")'')];}
          ];

          layer_rule = [
            {
              match.namespace = "rofi";
              blur = true;
              xray = true;
            }
          ];
        };
      };
  };
}
