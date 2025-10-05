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
      ExecStart = "${pkgs.ludusavi}/bin/ludusavi backup --force";
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
