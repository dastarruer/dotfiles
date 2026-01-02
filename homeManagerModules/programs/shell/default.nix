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
    dotfiles.shell.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the fish shell and starship.";
    };
  };

  dotfiles.shell = {
    fish.enable = lib.mkDefault config.dotfiles.shell.enable;
    starship.enable = lib.mkDefault config.dotfiles.shell.enable;
  };
}
