{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.swww.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable swww, a wallpaper daemon.";
    };
  };

  config = lib.mkIf config.myPrograms.swww.enable {
    services.swww.enable = true;

    # Start swww daemon on startup
    wayland.windowManager.hyprland.settings."exec-once" = [
      "swww-daemon &"
    ];
  };
}
