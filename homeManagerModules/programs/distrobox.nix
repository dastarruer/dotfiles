{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.distrobox.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable distrobox functionality.";
    };
  };

  config = lib.mkIf config.myPrograms.distrobox.enable {
    programs.distrobox = {
      enable = true;
    };
  };
}
