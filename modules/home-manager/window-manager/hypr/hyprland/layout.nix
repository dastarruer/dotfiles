{
  config,
  lib,
  ...
}: let
  tiling = config.home-manager.window-manager.hypr.hyprland.scrollable-tiling;
in {
  wayland.windowManager.hyprland.settings = {
    general.layout =
      if tiling.enable
      then "scrolling"
      else "dwindle";

    # Always split windows to the right
    dwindle.force_split = lib.mkIf (!tiling.enable) "2";
  };
}
