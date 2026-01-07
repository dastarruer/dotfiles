{...}: {
  imports = [
    ./programs
    ./scripts
    ./services
    ./window-manager

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
