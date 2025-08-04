{...}: {
  imports = [
    ./boot

    ./maintenance.nix
    ./networking.nix
    ./power-button.nix
    ./battery.nix
    # ./nix-mineral
  ];
}
