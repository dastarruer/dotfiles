{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.distrobox.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable distrobox functionality.";
    };
  };

  config = lib.mkIf config.dotfiles.distrobox.enable {
    programs.distrobox = {
      enable = true;
    };
  };
}
