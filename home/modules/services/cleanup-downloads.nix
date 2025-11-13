{pkgs, ...}: {
  systemd.user = {
    # Remove old files from downloads
    services.cleanup-downloads = {
      Unit = {
        Description = "Remove old files from Downloads directory";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "cleanup-downloads" ''
          #!/run/current-system/sw/bin/bash
          ${pkgs.libnotify}/bin/notify-send "Clearing downloads directory..." "it's that time of day!"

          # Delete files older than two days in the downloads dir
          ${pkgs.findutils}/bin/find /home/dastarruer/Downloads -mindepth 1 -mtime +2 -delete

          ${pkgs.libnotify}/bin/notify-send "Cleared downloads directory."
        ''}";
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
