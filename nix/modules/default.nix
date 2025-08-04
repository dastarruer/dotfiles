{...}: {
  imports = [
    ./desktops/hyprland
    ./boot
    ./battery.nix
    ./bluetooth.nix
    ./calibre.nix
    # ./kavita.nix
    ./keyboard.nix
    ./locale.nix
    ./maintenance.nix
    ./networking.nix
    ./power-button.nix
    ./stylix.nix
    ./system-packages.nix
    ./secrets.nix
    ./users.nix
  ];
}
