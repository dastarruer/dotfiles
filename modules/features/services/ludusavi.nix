{...}: {
  flake.nixosModules.services_ludusavi = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      saveDataPath = "${config.home.homeDirectory}/Documents/ludusavi-backup";
      backup = config.services.restic;
    in {
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
      home-manager.services.backup.backupPaths = lib.mkIf backup.enable [
        saveDataPath
      ];
    };
  };
}
