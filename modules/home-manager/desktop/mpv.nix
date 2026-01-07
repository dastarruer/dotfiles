{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.mpv.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enableAll;
      description = "Enable mpv, a video player.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.mpv.enable {
    programs.mpv.enable = true;
  };
}
