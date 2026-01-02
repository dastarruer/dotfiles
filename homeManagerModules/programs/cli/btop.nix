{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.cli.btop.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable btop, a terminal system monitor.";
    };
  };

  config = lib.mkIf config.dotfiles.cli.btop.enable {
    programs.btop.enable = true;
  };
}
