{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.mpv.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable mpv, a video player.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.mpv.enable {
    programs.mpv.enable = true;
  };
}
