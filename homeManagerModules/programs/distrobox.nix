{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.distrobox.enable = lib.mkEnableOption "Enable distrobox.";
  };

  config = lib.mkIf config.myPrograms.distrobox.enable {
    programs.distrobox = {
      enable = true;
    };
  };
}
