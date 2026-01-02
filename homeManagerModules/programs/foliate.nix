{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.foliate.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable foliate, an EPUB reader.";
    };
  };

  config = lib.mkIf config.myPrograms.foliate.enable {
    programs.foliate = {
      enable = true;

      settings = {
        invert = true;
      };
    };
  };
}
