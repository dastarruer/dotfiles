{
  config,
  pkgs,
  ...
}: {
  systemd.user = {
    enable = true;

    # Remove old files from downloads
    services.cleanup-downloads = {
      Unit = {
        Description = "Remove old files from Downloads directory";
      };
      Service = {
        Type = "oneshot";

        # Delete any files older than 5 days
        ExecStart = "${pkgs.findutils}/bin/find ${config.home.homeDirectory}/Downloads -type f -mtime +5 -delete";
      };
    };

    # A timer to trigger cleanup-downloads
    # Since the timer and service have the same name, the timer will trigger the service when it goes off
    timers.cleanup-downloads = {
      Unit = {
        Description = "Run cleanup-downloads.service daily";
      };
      Timer = {
        # Run once a day
        OnCalendar = "daily";

        # Run after wake from suspend if missed
        Persistent = true;
      };
      Install = {
        # Enable timer to start at boot (or when user session starts)
        WantedBy = ["timers.target"];
      };
    };
  };
}
