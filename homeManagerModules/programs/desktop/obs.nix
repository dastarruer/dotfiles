{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.desktop.enableAll;
      description = "Enable OBS, a screen recording app.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.obs.enable {
    programs.obs-studio.enable = true;

    # Create the save dir for obs
    systemd.user.tmpfiles.rules = [
      "d %h/Videos/screen-recordings - - - - -"
    ];
  };
}
