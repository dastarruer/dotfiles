{...}: {
  imports = [
    ./users.nix
    ./locale.nix
    ./boot.nix
    ./audio.nix
    ./hyprland.nix
    ./display-manager.nix
    # ./gnome.nix
    ./system-packages.nix
    ./keyboard.nix
    ./networking.nix
    ./bluetooth.nix
    ./maintenance.nix
  ];
}
