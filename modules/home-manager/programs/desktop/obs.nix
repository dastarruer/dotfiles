{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enableAll;
      description = "Enable OBS, a screen recording app.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.obs.enable {
    programs.obs-studio.enable = true;

    # Create the save dir for obs
    systemd.user.tmpfiles.rules = [
      "d %h/Videos/screen-recordings - - - - -"
    ];
  };
}
