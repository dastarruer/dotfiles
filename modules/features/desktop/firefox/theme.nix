{inputs, ...}: {
  flake.nixosModules.desktop_firefox = {config, ...}: {
    home-manager.users.dastarruer = let
      profile = config.custom.desktop.firefox.profile;
    in {
      imports = [
        inputs.textfox.homeManagerModules.default
      ];

      textfox = {
        enable = true;
        profiles = [profile];
        config = {
          displayTitles = false;
          tabs.vertical.enable = true;

          # Colors
          font.accent = "#${config.custom.theme.accent}";
          border.color = "#${config.lib.stylix.colors.base01}";

          # Margin
          navbar.margin = "0px";
        };
      };

      stylix.targets.firefox = {
        enable = true;
        colorTheme.enable = true;
        profileNames = [profile];
      };

      programs.firefox.profiles."${profile}".settings = {
        # Monocolor icons
        "shyfox.enable.ext.mono.toolbar.icons" = true;
        "shyfox.enable.ext.mono.context.icons" = true;
      };
    };
  };
}
