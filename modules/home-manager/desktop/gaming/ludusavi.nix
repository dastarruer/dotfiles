{
  config,
  lib,
  ...
}: let
  backup = config.home-manager.services.backup;
in {
  options = {
    home-manager.desktop.gaming.ludusavi.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.gaming.enable;
      description = "Enable ludusavi, a game-save backup tool.";
    };
  };

  config = let
    saveDataPath = "${config.home.homeDirectory}/Documents/ludusavi-backup";
  in
    lib.mkIf config.home-manager.desktop.gaming.ludusavi.enable {
      services.ludusavi = {
        enable = true;

        frequency = "daily";
        backupNotification = true;

        settings = {
          theme = "dark";
          language = "en-US";
          manifest.url = "https://raw.githubusercontent.com/mtkennerly/ludusavi-manifest/master/data/manifest.yaml";

          backup = {
            path = saveDataPath;
          };
          restore = {
            path = saveDataPath;
          };
        };
      };

      # Manually patch ludusavi timer
      systemd.user.timers.ludusavi.Timer = {
        Persistent = true;
        RandomizedDelaySec = "1h";
      };

      # Backup the ludusavi save dir
      home-manager.services.backup.backupPaths = lib.mkIf backup.enable lib.mkIf backup.enable [
        saveDataPath
      ];
    };
}
