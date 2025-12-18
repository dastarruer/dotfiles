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
    ./maintenance.nix
    ./fontconfig.nix
  ];
}
