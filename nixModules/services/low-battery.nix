{pkgs, ...}: {
  # Service to notify when battery is low
  systemd.services.low-battery-notify = {
    # Dependencies
    path = with pkgs; [
      bash
    ];

    unitConfig = {
      Description = "Notify user when battery is low";
    };

    serviceConfig = {
      ExecStart = ./scripts/low-battery.sh;
      Restart = "always";
    };

    wantedBy = ["default.target"];
  };
}
