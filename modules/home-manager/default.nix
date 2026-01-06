{...}: {
  imports = [
    ./programs
    ./services
    ./scripts

    ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
    ./stylix.nix
    ./gtk.nix
    ./qt.nix
    ./maintenance.nix
    ./secrets.nix
    ./fontconfig.nix
  ];
}
