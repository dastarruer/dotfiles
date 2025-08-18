{...}: {
  imports = [
    ./cleanup-downloads.nix
    ./smart-pause-resume.nix
  ];

  systemd.user.enable = true;
}
