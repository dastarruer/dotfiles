{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.direnv.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable direnv.";
    };
  };

  config = lib.mkIf config.myPrograms.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
