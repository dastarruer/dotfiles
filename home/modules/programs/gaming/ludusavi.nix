{pkgs, ...}: {
  home.packages = with pkgs; [
    ludusavi
  ];

  # Automate backups: https://github.com/mtkennerly/ludusavi/blob/master/docs/help/backup-automation.md
  systemd.user.services.ludusavi = {
    Unit = {
      Description = "Ludusavi backup";
    };

    Service = {
      ExecStart = "${pkgs.writeShellScript "ludusavi-backup" ''
        #!/run/current-system/sw/bin/bash
        ${pkgs.libnotify}/bin/notify-send "It's that time of day!" "Starting ludusavi backup..."
        ${pkgs.ludusavi}/bin/ludusavi backup --force || ${pkgs.libnotify}/bin/notify-send "Ludusavi backup failed" "Check system status for more information."
      ''}";
    };
  };

  systemd.user.timers.ludusavi = {
    Unit = {
      Description = "Ludusavi backup timer";
    };

    Timer = {
      OnCalendar = "16:00";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
