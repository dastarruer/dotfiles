{...}: {
  imports = [
    ./desktops/hyprland
    ./boot
    ./self-hosted
    ./users

    ./battery.nix
    ./bluetooth.nix
    ./maintenance.nix
    ./networking.nix
    ./power-button.nix
    ./stylix.nix
    ./system-packages.nix
    ./secrets.nix
  ];
}
