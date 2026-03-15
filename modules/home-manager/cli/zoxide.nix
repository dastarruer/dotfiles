{
  config,
  lib,
  ...
}: let
  fish = config.home-manager.cli.shell.fish;
in {
  options = {
    home-manager.cli.zoxide.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable zoxide.";
    };
  };

  config = lib.mkIf config.home-manager.cli.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = lib.mkIf config.home-manager.cli.shell.fish.enable true;
    };

    programs.fish.shellAliases.".." = lib.mkIf fish.enable "z ..";
  };
}
