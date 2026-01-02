{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.imv.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.desktop.enableAll;
      description = "Enable imv, an image viewer.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.imv.enable {
    programs.imv = {
      enable = true;
      settings = {
        options.background = "${config.lib.stylix.colors.base00}";
        aliases.q = "close";
        aliases.r = "rotate by 90";
      };
    };
  };
}
