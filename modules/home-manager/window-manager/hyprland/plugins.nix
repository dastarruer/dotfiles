{
  config,
  lib,
  pkgs,
  hyprlandPlugins,
  # hyprlandPlugins,
  ...
}: let
  cfg = config.home-manager.window-manager.hyprland.scrollable-tiling;
in {
  options = {
    home-manager.window-manager.hyprland.scrollable-tiling.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.hyprland.enable;
      description = "Enable scrollable tiling in hyprland, similar to niri functionality.";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      plugins = [
        hyprlandPlugins.hyprscrolling
      ];

      settings = {
        # For whatever reason, I need to add this manually
        exec-once = [
          "${pkgs.hyprland}/bin/hyprctl plugin load ${hyprlandPlugins.hyprscrolling}/lib/libhyprexpo.so"
        ];

        # Plugin needs to be allowed
        permission = [
          "${hyprlandPlugins.hyprscrolling}/lib/libhyprexpo.so, plugin, allow"
        ];

        "plugin:hyprscrolling" = {
          fullscreen_on_one_column = true;
          focus_fit_method = 1;
        };
      };
    };
  };
}
