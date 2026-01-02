{
  config,
  lib,
  ...
}: let
  hyprland = config.dotfiles.window-manager.hypr.hyprland;
in {
  options = {
    dotfiles.window-manager.swww.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable swww, a wallpaper daemon.";
    };
  };

  config = lib.mkIf config.dotfiles.window-manager.swww.enable {
    services.swww.enable = true;

    # Start swww daemon on startup
    wayland.windowManager.hyprland.settings."exec-once" = lib.mkIf hyprland.enable [
      "swww-daemon &"
    ];
  };
}
