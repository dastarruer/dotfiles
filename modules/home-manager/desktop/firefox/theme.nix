{config, ...}: {
  textfox = {
    enable = true;
    profiles = [config.home-manager.desktop.firefox.profile];
    config = {
      displayTitles = false;
      tabs.vertical.enable = true;

      # Colors
      font.accent = "#${config.home-manager.theme.accent}";
      border.color = "#${config.lib.stylix.colors.base01}";

      # Margin
      tabs.vertical.sidebery.margin = "0px";
      navbar.margin = "0px";
    };
  };

  stylix.targets.firefox = {
    enable = true;
    colorTheme.enable = true;
    profileNames = [config.home-manager.desktop.firefox.profile];
  };

  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}".settings = {
    # Monocolor icons
    "shyfox.enable.ext.mono.toolbar.icons" = true;
    "shyfox.enable.ext.mono.context.icons" = true;
  };
}
