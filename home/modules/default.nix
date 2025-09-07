{...}: {
  imports = [
    ./programs
    ./services

    ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
    ./gtk.nix
  ];
}
