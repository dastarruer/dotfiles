{...}: {
  # Enable the smart-pause-resume script, which plays and pauses multiple media players (https://github.com/erenseymen/smart-pause-resume/blob/master/smart-pause-resume.service)
  systemd.user.services.smart-pause-resume = {
    Unit = {
      Description = "Auto-pause previous media when new media starts";
    };

    Service = {
      ExecStart = "${./scripts/smart-pause-resume.sh}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
