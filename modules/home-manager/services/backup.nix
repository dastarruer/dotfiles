{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.services.backup;
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
    in
      lib.mkIf (builtins.pathExists usbPasswordPath && builtins.pathExists drivePasswordPath) {
        enable = true;
        backups = {
          usb = {
            repository = "${config.home.homeDirectory}/usb/backups";
            passwordFile = "${usbPasswordPath}";
            paths = config.home-manager.services.backup.backupPaths;
            initialize = true;
          };

          drive = {
            repository = "rclone:gdrive:backups";
            passwordFile = "${drivePasswordPath}";
            paths = config.home-manager.services.backup.backupPaths;
            initialize = true;

            # Refresh rclone auth token before backing up
            backupPrepareCommand = "${lib.getExe authRefreshScript}";

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

    nixpkgs.overlays = [
      (final: prev: {
        backup = prev.writeShellApplication {
          name = "backup";

          runtimeInputs = with prev; [
            systemd
            mount
            eject
            coreutils
          ];

          text = ''
            USB_DEVICE="/dev/sdb1"
            MOUNT_POINT="${config.home.homeDirectory}/usb"

            echo "Creating mount point..."
            mkdir -p $MOUNT_POINT

            echo "Mounting USB..."
            sudo mount $USB_DEVICE $MOUNT_POINT

            echo "Backing up to USB..."
            systemctl --user start restic-backups-usb.service

            echo "Backing up to drive..."
            systemctl --user start restic-backups-drive.service

            echo "Ejecting USB..."
            eject $USB_DEVICE

            echo "Deleting mount point..."
            rm -rf $MOUNT_POINT

            echo "All done!"
          '';
        };
      })
    ];

    # Add the package from the overlay to home.packages
    home.packages = [
      pkgs.backup
    ];
  };
}
