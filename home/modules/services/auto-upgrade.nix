{config, ...}: {
  systemd.user.services.auto-upgrade = {
    Unit = {
      Description = "Auto-upgrade system";

      # Run the service after auto-update-flake
      After = ["auto-update-flake.service"];
      Wants = ["auto-update-flake.service"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = ./scripts/auto-upgrade.sh;
      Environment = "SUDO_PASSWORD=${config.sops.secrets.sudo_password.path}";
    };

    Install = {
      WantedBy = ["multi-user.target"];
    };
  };

  systemd.user.services.auto-update-flake = {
    Unit = {
      Description = "Auto-update configuration flake";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = ./scripts/auto-update-flake.sh;
    };

    Install = {
      WantedBy = ["multi-user.target"];
    };
  };

  systemd.user.timers.auto-update-flake = {
    Unit = {
      Description = "Timer for auto-update-flake service";
    };

    Timer = {
      OnCalendar = "15:00";
      Persistent = true;
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
# if i ever switch it back to a nixos service
# {pkgs, ...}: {
#   # Service to auto upgrade system
#   systemd.services.upgrade-system = {
#     path = with pkgs; [
#       bash
#       libnotify
#       sudo
#       nix
#       nixos-rebuild
#       gitMinimal
#     ];
#     description = "Auto-upgrade system";
#     serviceConfig = {
#       Type = "oneshot";
#       ExecStart = ./scripts/upgrade-system.sh;
#       User = "root";
#     };
#     wantedBy = ["multi-user.target"];
#     after = ["network-online.target"];
#     wants = ["network-online.target"];
#   };
#   # Timer to trigger daily
#   systemd.timers.upgrade-system = {
#     wantedBy = ["timers.target"];
#     timerConfig = {
#       OnCalendar = "15:00";
#       Persistent = true;
#     };
#   };
# }

