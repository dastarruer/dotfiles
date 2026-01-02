{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.foliate.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.desktop.enableAll;
      description = "Enable foliate, an EPUB reader.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.foliate.enable {
    programs.foliate = {
      enable = true;

      settings = {
        invert = true;
      };
    };
  };
}
