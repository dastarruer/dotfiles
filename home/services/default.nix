{...}: {
  imports = [
    ./cleanup-downloads.nix
    ./upgrade-system.nix
    ./smart-pause-resume.nix
  ];

  systemd.user.enable = true;

  # Get the system password, some services will need sudo privileges
  sops.secrets.sudo_password = {};
}
