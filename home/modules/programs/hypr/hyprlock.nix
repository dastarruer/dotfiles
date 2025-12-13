{pkgs, ...}: {
  # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
  programs.hyprlock = {
    enable = true;
  };

  systemd.user.services.hyprlock = {
    Unit = {
      Description = "Lock screen with hyprlock before suspend";
      Before = ["sleep.target"];
    };

    Service = {
      Type = "forking";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";

      # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Custom_systemd_units
      ExecStartPost = "${pkgs.coreutils}/bin/sleep 1";
    };

    Install = {
      WantedBy = ["sleep.target"];
    };
  };
}
