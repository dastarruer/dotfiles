{...}: {
  # Enable the smart-pause-resume script, which plays and pauses multiple media players
  systemd.user.services.smart-pause-resume = {
    Unit = {
      Description = "Auto-pause previous media when new media starts";
    };

    Service = {
      ExecStart = "%h/bin/smart-pause-resume.sh";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
