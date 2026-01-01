{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.imv.enable = lib.mkEnableOption "Enable imv, an image viewer.";
  };

  config = lib.mkIf config.myPrograms.imv.enable {
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
