{pkgs, ...}: {
  # Service to upgrade system
  systemd.services.upgrade-system = {
    path = with pkgs; [
      bash
    ];

    unitConfig = {
      Description = "Auto-upgrade system.";

      # Wait for internet access
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };

    serviceConfig = {
      ExecStart = ./scripts/upgrade-system.sh;
      Restart = "on-failure";
    };

    wantedBy = ["default.target"];
  };

  # Timer to trigger upgrade-system.service daily
  systemd.timers.upgrade-system = {
    timerConfig = {
      OnCalendar = "15:00";
      Persistent = true; # run timer after system wakes up
    };

    wantedBy = ["timers.target"];
  };
}
