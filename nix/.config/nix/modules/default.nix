{...}: {
  imports = [
    ./users.nix
    ./locale.nix
    ./bootloader.nix
    ./audio.nix
    ./gnome.nix
    ./packages.nix
    ./keyboard.nix
  ];
}
