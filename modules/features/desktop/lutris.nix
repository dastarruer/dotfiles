{...}: {
  flake.nixosModules.desktop_lutris = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      ludusavi = hmConfig.services.ludusavi;
    in {
      programs.lutris = {
        enable = true;
        steamPackage = config.programs.steam.package;
        
        # https://github.com/NixOS/nixpkgs/issues/513245
        package = pkgs.lutris.override {
          # Intercept buildFHSEnv to modify target packages
          buildFHSEnv = args:
            pkgs.buildFHSEnv (args
              // {
                multiPkgs = envPkgs: let
                  # Fetch original package list
                  originalPkgs = args.multiPkgs envPkgs;

                  # Disable tests for openldap
                  customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
                in
                  # Replace broken openldap with the custom one
                  builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
              });
        };

        defaultWinePackage = pkgs.proton-ge-bin;
        protonPackages = with pkgs; [
          proton-ge-bin
        ];

        extraPackages = with pkgs; [
          gamescope
          gamemode
        ];

        runners.wine.settings = {
          system = {
            # Enable gamescope. Pretty useful since it has a frame limiter, and
            # automatically adjusts the game resolution to meet said frame rate.
            gamescope = "true";
            gamescope_flags = lib.concatStringsSep " " [
              "--force-grab-cursor" # Forces the game to capture mouse movement, so camera movement is not restricted
              "--expose-wayland" # Wayland support
            ];

            # Set fps limit of 30
            gamescope_fps_limiter = "30";

            # Fullscreen game window
            gamescope_window_mode = "-f";

            # Max fsr sharpness (0-20, where 0 is max and 20 is min)
            gamescope_fsr_sharpness = "0";

            # Set game to 720p
            gamescope_game_res = "1280x720";

            # Upscale game to my 1080p monitor
            gamescope_output_res = "1920x1080";
          };

          runner = {
            # Enable controller support
            autoconf_joypad = true;
          };
        };
      };

      # Add lutris to ludusavi
      services.ludusavi.settings = lib.mkIf ludusavi.enable {
        roots = [
          {
            store = "lutris";
            path = "${config.home-manager.users.dastarruer.home.homeDirectory}/.config/lutris";
            database = "${config.home-manager.users.dastarruer.home.homeDirectory}/.local/share/lutris/pgs.db";
          }
        ];
      };
    };
  };
}
