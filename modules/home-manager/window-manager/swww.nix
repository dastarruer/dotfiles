{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
in {
  options = {
    home-manager.window-manager.swww.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable swww, a wallpaper daemon.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.swww.enable {
    services.swww.enable = true;

    # Start swww daemon on startup
    wayland.windowManager.hyprland.settings."exec-once" = lib.mkIf hyprland.enable [
      "swww-daemon &"
    ];
  };
}
