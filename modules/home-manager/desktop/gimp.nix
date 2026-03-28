{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home-manager.desktop.gimp;
  backup = config.home-manager.services.backup;
  saveDir = "${config.home.homeDirectory}/Pictures/gimp";
in {
  options = {
    home-manager.desktop.gimp.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable GIMP, an image editing app.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gimp
    ];

    # Create the save dir for gimp
    systemd.user.tmpfiles.rules = [
      "d ${saveDir} - - - - -"
    ];

    home-manager.services.backup.backupPaths = lib.mkIf backup.enable [saveDir];
  };
}
