{...}: {
  imports = [
    ./smart-pause-resume.nix
    ./caps-lock.nix
    ./backup.nix
  ];

  # Get the system password, some services will need sudo privileges
  #  sops.secrets.sudo_password = {};
}
