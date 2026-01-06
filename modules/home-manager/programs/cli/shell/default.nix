{
  config,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./starship.nix
    ./fastfetch.nix
  ];

  options = {
    home-manager.cli.shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the fish shell and starship.";
    };
  };

  config = {
    home-manager.cli.shell = {
      fish.enable = lib.mkDefault config.home-manager.cli.shell.enable;
      starship.enable = lib.mkDefault config.home-manager.cli.shell.enable;
      fastfetch.enable = lib.mkDefault config.home-manager.cli.shell.enable;
    };
  };
}
