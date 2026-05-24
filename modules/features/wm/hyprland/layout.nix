{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    options.custom = {
      wm.scrolling.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable scrollable tiling in hyprland, similar to niri functionality.";
      };
    };

    config.home-manager.users.dastarruer = let
      scrolling = config.custom.wm.scrolling;
    in {
      wayland.windowManager.hyprland.settings.config = {
        general.layout =
          if scrolling.enable
          then "scrolling"
          else "dwindle";

        # Always split windows to the right
        dwindle = lib.mkIf (!scrolling.enable) {
          force_split = "2";
          pseudotile = true;
          preserve_split = true;
        };

        scrolling = lib.mkIf scrolling.enable {
          fullscreen_on_one_column = true;
          focus_fit_method = 1;
        };
      };
    };
  };
}
