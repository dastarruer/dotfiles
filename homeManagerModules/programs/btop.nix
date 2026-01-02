{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.btop.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable btop, a terminal system monitor.";
    };
  };

  config = lib.mkIf config.myPrograms.btop.enable {
    programs.btop.enable = true;
  };
}
