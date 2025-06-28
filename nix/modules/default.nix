{...}: {
  imports = [
    ./users.nix
    ./locale.nix
    ./bootloader.nix
    ./hyprland.nix
    # ./gnome.nix
    ./system-packages.nix
    ./keyboard.nix
    ./networking.nix
    ./bluetooth.nix
    ./maintenance.nix
  ];
}
