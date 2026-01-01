{...}: {
  imports = [
    ./fish.nix
    ./starship.nix
  ];

  myPrograms.shell = {
    fish.enable = true;
    starship.enable = true;
  };
}
