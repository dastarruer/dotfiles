{...}: {
  imports = [
    ./programs
    ./services

    ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
    ./stylix.nix
    ./gtk.nix
    ./maintenance.nix
  ];
}
