{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.mpv.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable mpv, a video player.";
    };
  };

  config = lib.mkIf config.myPrograms.mpv.enable {
    programs.mpv.enable = true;
  };
}
