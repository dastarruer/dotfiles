{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.services.backup;
  usbPasswordPath = config.sops.secrets."restic_passwords/usb".path;
  drivePasswordPath = config.sops.secrets."restic_passwords/drive".path;
  secretsExist = builtins.pathExists usbPasswordPath && builtins.pathExists drivePasswordPath;
  authRefreshScript = pkgs.writeShellApplication {
    name = "rclone-auth-refresh";
    runtimeInputs = with pkgs; [
      libnotify
      coreutils
      rclone
      xdg-utils # Needed to open a browser w rclone config reconnect command
    ];
    text = ''
      notify-send "Starting backup..." "Please sign in with the browser window."
      sleep 0.5
      # Auto accept all questions
      rclone config reconnect gdrive: --auto-confirm
    '';
  };
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

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # Always declare the secrets so sops-nix knows to create them
    {
      sops.secrets = {
        "restic_passwords/usb" = {};
        "restic_passwords/drive" = {};
      };
    }

    # Only include the services if the secret files actually exist on disk
    (lib.mkIf secretsExist {
      programs.rclone = {
        enable = true;
        remotes.gdrive.config = {
          type = "drive";
          scope = "drive";
        };
      };

      services.restic.enable = true;
      services.restic.backups = {
        usb = {
          repository = "${config.home.homeDirectory}/usb/backups";
          passwordFile = usbPasswordPath;
          paths = cfg.backupPaths;
          initialize = true;
        };

        drive = {
          repository = "rclone:gdrive:backups";
          passwordFile = drivePasswordPath;
          paths = cfg.backupPaths;
          initialize = true;
          backupPrepareCommand = "${lib.getExe authRefreshScript}";
          extraOptions = ["rclone.program=${pkgs.rclone}/bin/rclone"];
          rcloneOptions.config = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
          };
        };
      };

      home.packages = [
        (pkgs.writeShellApplication {
          name = "backup";
          runtimeInputs = with pkgs; [systemd mount eject coreutils];
          text = ''
            USB_DEVICE="/dev/sdb1"
            MOUNT_POINT="${config.home.homeDirectory}/usb"
            mkdir -p "$MOUNT_POINT"
            sudo mount "$USB_DEVICE" "$MOUNT_POINT"
            systemctl --user start restic-backups-usb.service
            systemctl --user start restic-backups-drive.service
            eject "$USB_DEVICE"
            rm -rf "$MOUNT_POINT"
          '';
        })
      ];
    })
  ]);
}
