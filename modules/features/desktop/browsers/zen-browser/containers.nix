{...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    browser = config.custom.desktop.browser.kind;
    profile = config.custom.desktop.browser.profile;
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        programs.zen-browser.profiles."${profile}" = {
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
