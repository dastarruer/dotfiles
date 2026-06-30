{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    profile = config.custom.desktop.browser.profile;
    browser = config.custom.desktop.browser.kind;
  in
    lib.mkIf (browser == "firefox") {
      home-manager.users.dastarruer = {
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
