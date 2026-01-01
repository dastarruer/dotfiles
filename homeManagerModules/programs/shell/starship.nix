{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.shell.starship.enable = lib.mkEnableOption "Enable starship.";
  };

  config = lib.mkIf config.myPrograms.shell.starship.enable {
    programs.starship = {
      enable = true;

      # These two features only work with the fish shell
      enableFishIntegration = lib.mkIf config.myPrograms.shell.fish.enable true;
      enableTransience = lib.mkIf config.myPrograms.shell.fish.enable true;
    };
  };
}
