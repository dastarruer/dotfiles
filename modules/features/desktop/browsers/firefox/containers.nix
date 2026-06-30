{...}: {
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
        programs.firefox.profiles."${profile}" = {
          # Set up containers
          containersForce = true;
          containers = {
            personal = {
              name = "personal";
              color = "turquoise";
              icon = "pet";
              id = 1;
            };
            school = {
              name = "school";
              color = "orange";
              icon = "dollar";
              id = 2;
            };
          };
        };
      };
    };
}
