{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home-manager.desktop.krita;
  backup = config.home-manager.services.backup;
  saveDir = "${config.home.homeDirectory}/Pictures/krita";
in {
  options = {
    home-manager.desktop.krita.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable krita, an image editing app.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.krita
    ];

    # Create the save dir for krita
    systemd.user.tmpfiles.rules = [
      "d ${saveDir} - - - - -"
    ];

    home-manager.services.backup.backupPaths = lib.mkIf backup.enable [saveDir];
  };
}
