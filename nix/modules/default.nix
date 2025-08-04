{...}: {
  imports = [
    ./desktops/hyprland
    ./system
    ./services
    ./users

    ./stylix.nix
    ./system-packages.nix
    ./secrets.nix
  ];
}
