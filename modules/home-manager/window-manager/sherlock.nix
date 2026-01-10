{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.window-manager.sherlock.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable sherlock, an application launcher. NOTE THAT THIS DOES NOT WORK AS OF NOW. ENABLING THIS MAY CAUSE THINGS TO BREAK.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.sherlock.enable {
    # example configuration
    programs.sherlock = {
      enable = true;
      systemd.enable = true; # Run as a daemon

      settings = {
        # config.json / config.toml
        # use nix syntax
        config = {};

        # fallback.json
        # A list of launchers
        launchers = [
          {
            name = "Calculator";
            type = "calculation";
            args = {
              capabilities = [
                "calc.math"
                "calc.units"
              ];
            };
            priority = 1;
          }
          {
            name = "App Launcher";
            type = "app_launcher";
            args = {};
            priority = 2;
            home = "Home";
          }
        ];

        # sherlock_alias.json
        # use nix syntax
        aliases = {
          vesktop = {name = "Discord";};
        };

        # main.css
        style =
          /*
          css
          */
          ''
            * {
                font-family: sans-serif;
            }
          '';

        # sherlockignore
        ignore = ''
          Avahi*
        '';
      };
    };
  };
}
