# doesn't really work as of now...
{...}: {
  flake.nixosModules.wm = {...}: {
    # home-manager.users.dastarruer = {
    #   # example configuration
    #   programs.sherlock = {
    #     enable = true;
    #     systemd.enable = true; # Run as a daemon

    #     settings = {
    #       # config.json / config.toml
    #       # use nix syntax
    #       config = {};

    #       # fallback.json
    #       # A list of launchers
    #       launchers = [
    #         {
    #           name = "Calculator";
    #           type = "calculation";
    #           args = {
    #             capabilities = [
    #               "calc.math"
    #               "calc.units"
    #             ];
    #           };
    #           priority = 1;
    #         }
    #         {
    #           name = "App Launcher";
    #           type = "app_launcher";
    #           args = {};
    #           priority = 2;
    #           home = "Home";
    #         }
    #       ];

    #       # sherlock_alias.json
    #       # use nix syntax
    #       aliases = {
    #         vesktop = {name = "Discord";};
    #       };

    #       # main.css
    #       style =
    #         /*
    #         css
    #         */
    #         ''
    #           * {
    #               font-family: sans-serif;
    #           }
    #         '';

    #       # sherlockignore
    #       ignore = ''
    #         Avahi*
    #       '';
    #     };
    #   };
    # };
  };
}
