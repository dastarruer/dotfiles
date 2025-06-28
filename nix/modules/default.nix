{...}: {
  imports = [
    ./users.nix
    ./locale.nix
    ./bootloader.nix
    ./audio.nix
    ./hyprland.nix
    # ./gnome.nix
    ./system-packages.nix
    ./keyboard.nix
    ./networking.nix
    ./bluetooth.nix
    ./maintenance.nix
  ];
}
