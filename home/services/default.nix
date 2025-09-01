{...}: {
  imports = [
    ./cleanup-downloads.nix
    ./upgrade-system.nix
    ./smart-pause-resume.nix
  ];

  systemd.user.enable = true;
}
