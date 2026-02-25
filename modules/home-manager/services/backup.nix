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
      "restic/passwords/usb" = {};
      "restic/passwords/drive" = {};
      "restic/drive/client_id" = {};
      "restic/drive/client_secret" = {};
    };

    programs.rclone = {
      enable = true;
      remotes.gdrive.config = {
        type = "drive";
        scope = "drive";
        #   client_id = "${}";
        #   client_secret = "${builtins.readFile clientSecretPath}";
      };
    };

    services.restic = let
      usbPasswordPath = config.sops.secrets."restic/passwords/usb".path;
      drivePasswordPath = config.sops.secrets."restic/passwords/drive".path;

      clientIdPath = config.sops.secrets."restic/passwords/usb".path;
      clientSecretPath = config.sops.secrets."restic/passwords/drive".path;
    in
      lib.mkIf (builtins.pathExists usbPasswordPath
        && builtins.pathExists drivePasswordPath
        && builtins.pathExists clientIdPath
        && builtins.pathExists clientSecretPath) {
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
            # initialize = true;

            extraOptions = [
              "rclone.program=${pkgs.rclone}/bin/rclone"
            ];

            rcloneOptions = {
              config = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
              drive-client-id = builtins.readFile clientIdPath;
              drive-client-secret = builtins.readFile clientSecretPath;
            };

            timerConfig = {
              OnCalendar = "daily";
              Persistent = true;
              RandomizedDelaySec = "1h";
            };
          };
        };
      };

    # Run rclone authenticate before starting the backup
    # Overriding this means that the repo will not be auto initialized by the restic service (see https://github.com/nix-community/home-manager/blob/5bd3589390b431a63072868a90c0f24771ff4cbb/modules/services/restic.nix#L484)
    systemd.user.services.restic-backups-drive.Service.ExecStartPre = let
      usbPasswordPath = config.sops.secrets."restic/passwords/usb".path;
      drivePasswordPath = config.sops.secrets."restic/passwords/drive".path;

      cmd = lib.getExe (
        pkgs.writeShellApplication {
          name = "rclone-auth";
          runtimeInputs = with pkgs; [
            libnotify
            rclone
          ];
          text = ''
            notify-send "Starting automated remote backup..." "Please sign in with the browser window."
            rclone config reconnect gdrive: --non-interactive
          '';
        }
      );
    in
      lib.mkForce (
        if (builtins.pathExists usbPasswordPath && builtins.pathExists drivePasswordPath)
        then cmd
        else ""
      );
  };
}
