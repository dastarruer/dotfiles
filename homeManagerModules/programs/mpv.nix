{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.mpv.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable mpv, a video player.";
    };
  };

  config = lib.mkIf config.dotfiles.mpv.enable {
    programs.mpv.enable = true;
  };
}
