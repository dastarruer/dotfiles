{...}: {
  imports = [
    ./programs
    ./shell

    ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
    ./gtk.nix
    ./maintenance.nix
  ];
}
