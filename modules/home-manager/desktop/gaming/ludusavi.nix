{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.gaming.ludusavi.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.gaming.enable;
      description = "Enable ludusavi, a game-save backup tool.";
    };
  };

  config = let
    backupPath = "${config.home.homeDirectory}/Documents/ludusavi-backup";
  in
    lib.mkIf config.home-manager.desktop.gaming.ludusavi.enable {
      services.ludusavi = {
        enable = true;

        frequency = "daily";
        backupNotification = true;

        settings = {
          theme = "light";
          language = "en-US";
          manifest.url = "https://raw.githubusercontent.com/mtkennerly/ludusavi-manifest/master/data/manifest.yaml";

          backup = {
            path = backupPath;
          };
          restore = {
            path = backupPath;
          };
        };
      };

      # Backup the ludusavi save dir
      home-manager.cli.rclone.backupPaths = [
        backupPath
      ];
    };
}
