{...}: {
  imports = [
    ./desktops/hyprland
    ./boot
    ./users

    ./battery.nix
    ./bluetooth.nix
    ./calibre.nix
    # ./kavita.nix
    ./maintenance.nix
    ./networking.nix
    ./power-button.nix
    ./stylix.nix
    ./system-packages.nix
    ./secrets.nix
  ];
}
