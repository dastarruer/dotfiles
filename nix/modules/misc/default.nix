{...}: {
  imports = [
    ./bluetooth.nix
    ./keyboard.nix
    ./locale.nix
    ./maintenance.nix
    ./networking.nix
    ./system-packages.nix
    ./users.nix
  ];
}
