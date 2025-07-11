{...}: {
  imports = [
    ./hyprland
    ./programs
    ./shell

    # Has trouble with stylix, so i cant be bothered to fix it
    # ./flatpak.nix
    ./packages.nix
    ./symlinks.nix
  ];
}
