{pkgs, ...}: {
  # Service to upgrade system
  systemd.user.services.upgrade-system = {
    Unit = {
      Description = "Auto-upgrade system.";

      # Wait for internet access
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };

    Service = {
      ExecStart = ./scripts/upgrade-system.sh;
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  # Timer to trigger upgrade-system.service daily
  systemd.user.timers.upgrade-system = {
    Timer = {
      OnCalendar = "15:00";
      Persistent = true; # run timer after system wakes up
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
