{
  config,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./starship.nix
  ];

  options = {
    myPrograms.shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the fish shell and starship.";
    };
  };

  myPrograms.shell = {
    fish.enable = lib.mkDefault config.myPrograms.shell.enable;
    starship.enable = lib.mkDefault config.myPrograms.shell.enable;
  };
}
