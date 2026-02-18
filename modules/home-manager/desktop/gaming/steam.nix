{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.desktop.gaming.steam;
  backup = config.home-manager.services.backup;
in {
  options = {
    home-manager.desktop.gaming.steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.gaming.enable;
      description = "Enable steam.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.steam
    ];

    # Backup mods for various games
    home-manager.services.backup.backupPaths = lib.mkIf backup.enable [
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/mods"
    ];
  };
}
