{...}: {
  imports = [
    ./cleanup-downloads.nix
    ./smart-pause-resume.nix
    ./auto-upgrade.nix
  ];

  systemd.user.enable = true;

  # Get the system password, some services will need sudo privileges
#  sops.secrets.sudo_password = {};
}
