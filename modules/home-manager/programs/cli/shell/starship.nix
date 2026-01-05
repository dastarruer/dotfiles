{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.cli.shell.starship.enable = lib.mkEnableOption "Enable starship.";
  };

  config = lib.mkIf config.dotfiles.cli.shell.starship.enable {
    programs.starship = {
      enable = true;

      # These two features only work with the fish shell
      enableFishIntegration = lib.mkIf config.dotfiles.cli.shell.fish.enable true;
      enableTransience = lib.mkIf config.dotfiles.cli.shell.fish.enable true;
    };
  };
}
