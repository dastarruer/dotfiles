{...}: {
  imports = [
    ./programs
    ./services
    ./shell

    ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
    ./gtk.nix
  ];
}
