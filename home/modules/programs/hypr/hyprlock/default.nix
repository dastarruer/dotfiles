{pkgs, ...}: {
  imports = [
    ./pfp.nix
    ./password-input.nix
    ./date.nix
    ./battery-status.nix
    ./background.nix
  ];

  # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
  programs.hyprlock = {
    enable = true;
  };

  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Custom_systemd_units
  systemd.user.services.hyprlock = {
    Unit = {
      Description = "Lock the screen before sleep";
      Before = ["sleep.target"];
    };

    Install = {
      WantedBy = ["sleep.target"];
    };

    Service = {
      Type = "forking";
      User = "%I";
      Environment = "DISPLAY=:0";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
      ExecStartPost = "${pkgs.coreutils}/bin/sleep 1";
    };
  };
}
