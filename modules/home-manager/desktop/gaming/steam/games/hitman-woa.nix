{
  lib,
  config,
  ...
}: let
  backup = config.home-manager.services.backup;
in {
  programs.steam.config.apps.hitmanwoa = {
    id = 1659040;
    launchOptions = {
      args = [
        "-skip_launcher"
      ];
    };
  };

  # Backup hitman mods
  home-manager.services.backup.backupPaths = lib.mkIf backup.enable [
    "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/Simple\ Mod\ Framework"
  ];
}
