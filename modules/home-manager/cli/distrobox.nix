{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.cli.distrobox.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable distrobox functionality.";
    };
  };

  config = lib.mkIf config.home-manager.cli.distrobox.enable {
    programs.distrobox = {
      enable = true;
    };
  };
}
