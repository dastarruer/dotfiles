{...}: {
  imports = [
    ./cli
    ./desktop
    ./scripts
    ./services
    ./window-manager

    ./flatpak.nix
    ./symlinks.nix
    ./stylix.nix
    ./gtk.nix
    ./qt.nix
    ./secrets.nix
    ./fontconfig.nix
  ];
}
