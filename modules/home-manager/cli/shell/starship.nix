{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.cli.shell.starship.enable = lib.mkEnableOption "Enable starship.";
  };

  config = lib.mkIf config.home-manager.cli.shell.starship.enable {
    programs.starship = {
      enable = true;

      # These two features only work with the fish shell
      enableFishIntegration = lib.mkIf config.home-manager.cli.shell.fish.enable true;
      enableTransience = lib.mkIf config.home-manager.cli.shell.fish.enable true;
    };
  };
}
