{
  config,
  lib,
  ...
}: let
  tiling = config.home-manager.window-manager.hyprland.scrollable-tiling;
in {
  options = {
    home-manager.window-manager.hyprland.scrollable-tiling.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.hyprland.enable;
      description = "Enable scrollable tiling in hyprland, similar to niri functionality.";
    };
  };

  config = {
    wayland.windowManager.hyprland.settings = {
      general.layout =
        if tiling.enable
        then "scrolling"
        else "dwindle";

      # Always split windows to the right
      dwindle.force_split = lib.mkIf (!tiling.enable) "2";

      scrolling = lib.mkIf tiling.enable {
        fullscreen_on_one_column = true;
        focus_fit_method = 1;
      };
    };
  };
}
