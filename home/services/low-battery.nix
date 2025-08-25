{...}: {
  # Service to notify when battery is low
  systemd.user.services.low-battery-notify = {
    Unit = {
      Description = "Notify user when battery is low";
    };

    Service = {
      ExecStart = "%h/bin/low-battery.sh";
      Restart = "always";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
