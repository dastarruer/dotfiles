{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home-manager.desktop.kdenlive;
  backup = config.home-manager.services.backup;
  saveDir = "${config.home.homeDirectory}/Videos/kdenlive";
in {
  options = {
    home-manager.desktop.kdenlive.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable Kdenlive, a video editing app.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.kdenlive
    ];

    # Create the save dir for kdenlive
    systemd.user.tmpfiles.rules = [
      "d ${saveDir} - - - - -"
    ];

    home-manager.services.backup.backupPaths = lib.mkIf backup.enable [saveDir];
  };
}
