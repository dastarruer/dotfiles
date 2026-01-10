{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.imv.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable imv, an image viewer.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.imv.enable {
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
