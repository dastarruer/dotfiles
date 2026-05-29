# The rofi config is from here: https://github.com/sdushantha/dotfiles/blob/master/rofi/.config/rofi/themes/default.rasi
{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.custom.wm.wm == "hyprland";
      launcher = config.custom.wm.launcher;
    in
      lib.mkIf (launcher == "rofi") {
        stylix.targets.rofi.enable = false;

        programs.rofi = {
          enable = true;
          location = "top";
        };

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
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
