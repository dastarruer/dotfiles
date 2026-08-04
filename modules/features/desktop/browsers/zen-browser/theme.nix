{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    profile = config.custom.desktop.browser.profile;
    browser = config.custom.desktop.browser.kind;
    colors = config.lib.stylix.colors;
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        stylix.targets.zen-browser = {
          enable = true;
          profileNames = [profile];
        };

        programs.zen-browser.profiles."${profile}" = {
          mods = [
            # Disable rounded corners (https://zen-browser.app/mods/c6813222-6571-4ba6-8faf-58f3343324f6/?page=2)
            "c6813222-6571-4ba6-8faf-58f3343324f6"
          ];
          settings = {
            "zen.widget.linux.transparency" = false;

            # Set both to dark mode
            "browser.theme.content-theme" = 2;
            "browser.theme.toolbar-theme" = 2;
          };
        };
      };
    };
}
