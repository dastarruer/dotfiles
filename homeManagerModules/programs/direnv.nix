{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.direnv.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable direnv.";
    };
  };

  config = lib.mkIf config.dotfiles.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
