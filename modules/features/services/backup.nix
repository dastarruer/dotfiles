# You can check if this is enabled by checking config.custom.backup.enable
{...}: {
  flake.nixosModules.services_backup = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;

    usbPasswordPath = hmConfig.sops.secrets."restic_passwords/usb".path;
    drivePasswordPath = hmConfig.sops.secrets."restic_passwords/drive".path;

    secretsExist = builtins.pathExists usbPasswordPath && builtins.pathExists drivePasswordPath;

    authRefreshScript = pkgs.writeShellApplication {
      name = "rclone-auth-refresh";
      runtimeInputs = with pkgs; [
        libnotify
        coreutils
        rclone
        xdg-utils
      ];
      text = ''
        notify-send "Starting backup..." "Please sign in with the browser window."
        sleep 0.5
        rclone config reconnect gdrive: --auto-confirm
      '';
    };
  in {
    options.custom = {
      backup = {
        # This option only exists to safely check if backups are enabled without infinite recursion. Just importing the services_backup module enables it on its own
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          readOnly = true;
        };
        secretsReady = lib.mkOption {
          type = lib.types.bool;
          default = false;
          readOnly = true;
        };
        backupPaths = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          description = "List of local directories to back.";
          example = ["/home/user/Documents" "/home/user/Pictures"];
        };
      };
    };

    config.home-manager.users.dastarruer = lib.mkIf config.custom.backup.enable {
      sops.secrets = {
        "restic_passwords/usb" = {};
        "restic_passwords/drive" = {};
      };

      custom.backup.secretsReady = secretsExist;

      programs.rclone = {
        enable = true;
        remotes.gdrive.config = {
          type = "drive";
          scope = "drive";
        };
      };

      services.restic.enable = true;
      services.restic.backups = lib.mkIf config.custom.backup.secretsReady {
        usb = {
          repository = "${config.home-manager.users.dastarruer.home.homeDirectory}/usb/backups";
          passwordFile = usbPasswordPath;
          paths = config.custom.backup.backupPaths;
          initialize = true;
          pruneOpts = ["--keep-last 3"];
        };

        drive = {
          repository = "rclone:gdrive:backups";
          passwordFile = drivePasswordPath;
          paths = config.custom.backup.backupPaths;
          initialize = true;
          pruneOpts = ["--keep-last 3"];
          backupPrepareCommand = "${lib.getExe authRefreshScript}";
          extraOptions = ["rclone.program=${pkgs.rclone}/bin/rclone"];
          rcloneOptions.config = "${config.home-manager.users.dastarruer.home.homeDirectory}/.config/rclone/rclone.conf";
          timerConfig = {
            OnCalendar = "daily";
            RandomizedDelaySec = "1h";
            Persistent = true;
          };
        };
      };

      home.packages = [
        (pkgs.writeShellApplication {
          name = "backup";
          runtimeInputs = with pkgs; [
            systemd
            mount
            eject
            coreutils
          ];
          text = ''
            USB_DEVICE="/dev/sda"
            MOUNT_POINT="${config.home-manager.users.dastarruer.home.homeDirectory}/usb"
            mkdir -p "$MOUNT_POINT"
            sudo mount "$USB_DEVICE" "$MOUNT_POINT"
            systemctl --user start restic-backups-usb.service
            systemctl --user start restic-backups-drive.service
            eject "$USB_DEVICE"
            rm -rf "$MOUNT_POINT"
          '';
        })
      ];
    };
  };
}
