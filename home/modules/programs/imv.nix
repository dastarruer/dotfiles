{config, ...}: {
  programs.imv = {
    enable = true;
    settings = {
      options.background = "${config.lib.stylix.colors.base00}";
      aliases.q = "close";
    };
  };
}
