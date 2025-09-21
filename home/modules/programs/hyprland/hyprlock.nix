{pkgs, ...}: {
  # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
  programs.hyprlock = {
    enable = true;
  };

  systemd.user.services.hyprlock = {
    Unit = {
      Description = "Lock screen with Hyprlock before suspend";
      Before = ["sleep.target"];
    };

    Service = {
      Type = "forking";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
    };

    Install = {
      WantedBy = ["sleep.target"];
    };
  };
}
