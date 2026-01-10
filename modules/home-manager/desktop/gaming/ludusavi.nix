{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.desktop.gaming.ludusavi.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.gaming.enable;
      description = "Enable ludusavi, a game-save backup tool.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.gaming.ludusavi.enable {
    home.packages = with pkgs; [
      ludusavi
    ];

    # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
    xdg.configFile = {
      "ludusavi/config.yaml".enable = false;
    };

    # Automate backups: https://github.com/mtkennerly/ludusavi/blob/master/docs/help/backup-automation.md
    systemd.user.services.ludusavi-backup = {
      Unit = {
        Description = "Ludusavi backup";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };

      Service = {
        ExecStart = "${pkgs.writeShellScript "ludusavi-backup" ''
          #!/run/current-system/sw/bin/bash
          ${pkgs.libnotify}/bin/notify-send "It's that time of day!" "Starting ludusavi backup..."
          ${pkgs.ludusavi}/bin/ludusavi backup --force || ${pkgs.libnotify}/bin/notify-send "Ludusavi backup failed" "Check system status for more information."
        ''}";
      };
    };

    # Timer to trigger automatic backups daily
    systemd.user.timers.ludusavi-backup = {
      Unit = {
        Description = "Ludusavi backup timer";
      };

      Timer = {
        OnCalendar = "Sat 11:00";
      };

      Install = {
        WantedBy = ["timers.target"];
      };
    };

    # Backup the ludusavi save dir
    home-manager.cli.rclone.backupPaths = [
      "${config.home.homeDirectory}/Documents/ludusavi-backup"
    ];
  };
}
