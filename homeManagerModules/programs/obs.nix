{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable OBS, a screen recording app.";
    };
  };

  config = lib.mkIf config.dotfiles.obs.enable {
    programs.obs-studio.enable = true;

    # Create the save dir for obs
    systemd.user.tmpfiles.rules = [
      "d %h/Videos/screen-recordings - - - - -"
    ];
  };
}
