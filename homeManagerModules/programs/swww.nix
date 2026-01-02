{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.swww.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable swww, a wallpaper daemon.";
    };
  };

  config = lib.mkIf config.dotfiles.swww.enable {
    services.swww.enable = true;

    # Start swww daemon on startup
    wayland.windowManager.hyprland.settings."exec-once" = [
      "swww-daemon &"
    ];
  };
}
