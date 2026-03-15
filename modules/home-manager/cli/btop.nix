{
  config,
  lib,
  ...
}: let
  fish = config.home-manager.cli.shell.fish;
in {
  options = {
    home-manager.cli.btop.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable btop, a terminal system monitor.";
    };
  };

  config = lib.mkIf config.home-manager.cli.btop.enable {
    programs.btop.enable = true;

    programs.fish.shellAliases.b = lib.mkIf fish.enable "btop";
  };
}
