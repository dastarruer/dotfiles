{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.services.backup;
in {
  options = {
    home-manager.services.backup = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.home-manager.services.enable;
        description = "Enable daily automated backups.";
      };
      backupPaths = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of local directories to back.";
        example = ["/home/user/Documents" "/home/user/Pictures"];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Declare restic password files
    sops.secrets = {
      "restic_passwords/usb" = {};
      "restic_passwords/drive" = {};
    };

    programs.rclone = {
      enable = true;
      remotes.gdrive.config = {
        type = "drive";
        scope = "drive";
      };
    };

    services.restic = let
      usbPasswordPath = config.sops.secrets."restic_passwords/usb".path;
      drivePasswordPath = config.sops.secrets."restic_passwords/drive".path;
    in {
      enable = true;
      backups = lib.mkIf (builtins.pathExists usbPasswordPath && builtins.pathExists drivePasswordPath) {
        usb = {
          repository = "/mnt/usb/backups";
          passwordFile = "${usbPasswordPath}";
          paths = config.home-manager.services.backup.backupPaths;
          initialize = true;
        };

        drive = {
          repository = "rclone:gdrive:backups";
          passwordFile = "${drivePasswordPath}";
          paths = config.home-manager.services.backup.backupPaths;
          initialize = true;

          extraOptions = [
            "rclone.program=${pkgs.rclone}/bin/rclone"
          ];

          rcloneOptions = {
            config = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
          };

          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
            RandomizedDelaySec = "1h";
          };
        };
      };
    };
  };
}
