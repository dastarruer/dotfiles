{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.direnv.enable = lib.mkEnableOption "Enable direnv, a program to dynamically load and unload dev environments.";
  };

  config = lib.mkIf config.myPrograms.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
