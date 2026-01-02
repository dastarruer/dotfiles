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
    dotfiles.cli.shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the fish shell and starship.";
    };
  };

  config = {
    dotfiles.cli.shell = {
      fish.enable = lib.mkDefault config.dotfiles.cli.shell.enable;
      starship.enable = lib.mkDefault config.dotfiles.cli.shell.enable;
      fastfetch.enable = lib.mkDefault config.dotfiles.cli.shell.enable;
    };
  };
}
