{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.distrobox.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable distrobox functionality.";
    };
  };

  config = lib.mkIf config.home-manager.distrobox.enable {
    programs.distrobox = {
      enable = true;
    };
  };
}
