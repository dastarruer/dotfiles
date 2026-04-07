{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    options.custom = {
      wm.scrollable-tiling.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.custom.wm.hyprland.enable;
        description = "Enable scrollable tiling in hyprland, similar to niri functionality.";
      };
    };

    config.home-manager.users.dastarruer = let
      tiling = config.custom.wm.hyprland.scrollable-tiling;
    in {
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
  };
}
