{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.obs.enable = lib.mkEnableOption "Enable OBS, a screen recording app.";
  };

  config = lib.mkIf config.myPrograms.obs.enable {
    programs.obs-studio.enable = true;

    # Create the save dir for obs
    systemd.user.tmpfiles.rules = [
      "d %h/Videos/screen-recordings - - - - -"
    ];
  };
}
