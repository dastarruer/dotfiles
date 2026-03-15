{
  config,
  lib,
  ...
}: let
  fish = config.home-manager.cli.shell.fish;
in {
  options = {
    home-manager.cli.shell.starship.enable = lib.mkEnableOption "Enable starship.";
  };

  config = lib.mkIf config.home-manager.cli.shell.starship.enable {
    programs.starship = {
      enable = true;

      # These two features only work with the fish shell
      enableFishIntegration = fish.enable;
      enableTransience = lib.mkIf fish.enable true;
    };
  };
}
