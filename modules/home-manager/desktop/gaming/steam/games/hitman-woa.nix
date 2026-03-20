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
    "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/README.md"

    # Freelancer variations stuff
    "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/Retail/mods/MissionCompanion.dll"
    "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/Retail/mods/FreelancerVariations.json"
    "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN\ 3/Retail/mods/missioncompanion.ini"
  ];
}
