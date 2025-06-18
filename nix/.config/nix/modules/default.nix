{...}: {
  imports = [
    ./users.nix
    ./locale.nix
    ./bootloader.nix
    ./hyprland.nix
    # ./gnome.nix
    ./packages.nix
    ./keyboard.nix
    ./networking.nix
    ./spicetify.nix
  ];
}
