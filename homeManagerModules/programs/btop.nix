{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.btop.enable = lib.mkEnableOption "Enable btop, a system monitoring program.";
  };

  config = lib.mkIf config.myPrograms.btop.enable {
    programs.btop.enable = true;
  };
}
