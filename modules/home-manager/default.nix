{...}: {
  imports = [
    ./cli
    ./desktop
    ./scripts
    ./services
    ./window-manager

    ./flatpak.nix
    ./stylix.nix
    ./gtk.nix
    ./qt.nix
    ./secrets.nix
  ];
}
