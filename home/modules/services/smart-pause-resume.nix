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

  # Add pause-all script to nixpkgs
  nixpkgs.overlays = [
    (final: prev: {
      pause-all = prev.writeShellApplication {
        name = "pause-all";

        runtimeInputs = with prev; [
          systemdMinimal
          playerctl
        ];

        text = ''
          if systemctl --user --quiet is-active smart-pause-resume.service; then
            systemctl --user stop smart-pause-resume.service
            playerctl --all-players pause
            systemctl --user start smart-pause-resume.service
          else
            playerctl --all-players pause
          fi
        '';
      };
    })
  ];
}
