{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.mpv.enable = lib.mkEnableOption "Enable mpv, a video player.";
  };

  config = lib.mkIf config.myPrograms.mpv.enable {
    programs.mpv.enable = true;
  };
}
