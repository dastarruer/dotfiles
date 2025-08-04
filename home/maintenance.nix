{
  config,
  pkgs,
  ...
}: {
  # Remove old files from downloads directory
  systemd.services.cleanup-downloads = {
    description = "Remove old files from Downloads directory";
    serviceConfig = {
      Type = "oneshot";

      # Delete any files older than 5 days
      ExecStart = "${pkgs.findutils}/bin/find ${config.users.users.dastarruer.home}/Downloads -type f -mtime +5 -delete";
    };
  };

  # A timer to trigger the cleanup-downloads service
  # Since both the timer and service have the same name, the timer will automatically trigger the service to run
  systemd.timers.cleanup-downloads = {
    description = "Run cleanup-downloads.service daily";
    wantedBy = ["timers.target"];
    timerConfig = {
      # Run once a day
      OnCalendar = "daily";

      # Run after wake from suspend
      Persistent = true;
    };
  };
}
