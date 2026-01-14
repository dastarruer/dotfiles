{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.foliate.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable foliate, an EPUB reader.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.foliate.enable {
    programs.foliate = {
      enable = true;
    };
  };
}
