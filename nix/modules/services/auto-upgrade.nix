{pkgs, ...}: {
  # Service to auto upgrade system
  systemd.services.upgrade-system = {
    path = with pkgs; [
      bash
      libnotify
      nix
      nixos-rebuild
    ];

    description = "Auto-upgrade system";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ./scripts/upgrade-system.sh;
    };
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];
  };

  # Timer to trigger daily
  systemd.timers.upgrade-system = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "15:00";
      Persistent = true;
    };
  };
}
# if i ever switch it back to a hm service
# {config, ...}: {
#   systemd.user.services.auto-upgrade = {
#     Unit = {
#       Description = "Auto-upgrade system";
#       After = ["network-online.target"];
#       Wants = ["network-online.target"];
#     };
#     Service = {
#       Type = "oneshot";
#       ExecStart = ./scripts/upgrade-system.sh;
#       Environment = "SUDO_PASSWORD=${config.sops.secrets.sudo_password.path}";
#     };
#     Install = {
#       WantedBy = ["multi-user.target"];
#     };
#   };
#   systemd.user.timers.auto-upgrade = {
#     Unit = {
#       Description = "Timer for auto-upgrade system";
#     };
#     Timer = {
#       OnCalendar = "15:00";
#       Persistent = true;
#     };
#     Install = {
#       WantedBy = ["timers.target"];
#     };
#   };
# }

