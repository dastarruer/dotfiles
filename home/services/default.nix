{...}: {
  imports = [
    ./cleanup-downloads.nix
    ./smart-pause-resume.nix
    ./upgrade-system.nix
  ];

  systemd.user.enable = true;
}
