{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.desktop.gaming.steam;
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
    home-manager.cli.rclone.backupPaths = [
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/mods"
    ];
  };
}
