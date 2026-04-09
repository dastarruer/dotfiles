{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
in {
  options = {
    home-manager.window-manager.awww.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable awww, a wallpaper daemon.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.awww.enable {
    services.awww.enable = true;

    # Start awww daemon on startup
    wayland.windowManager.hyprland.settings."exec-once" = lib.mkIf hyprland.enable [
      "awww-daemon &"
    ];
  };
}
