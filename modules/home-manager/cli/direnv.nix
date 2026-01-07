{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.cli.direnv.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable direnv.";
    };
  };

  config = lib.mkIf config.home-manager.cli.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
