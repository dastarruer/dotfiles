{...}: {
  imports = [
    ./smart-pause-resume.nix
    ./auto-upgrade.nix
  ];

  # Get the system password, some services will need sudo privileges
  #  sops.secrets.sudo_password = {};
}
