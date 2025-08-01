{...}: {
  imports = [
    ./boot

    ./maintenance.nix
    ./networking.nix
    ./power.nix
    # ./nix-mineral
  ];
}
