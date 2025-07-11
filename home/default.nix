{...}: {
  imports = [
    ./programs
    ./shell

    # flatpak.nix trouble with stylix, so i cant be bothered to fix it
    # ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
  ];
}
