{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;

    colors = config.lib.stylix.colors;
    fonts = config.stylix.fonts;
  in
    lib.mkIf (bar == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
      ];

      nix.settings = {
        extra-substituters = ["https://noctalia.cachix.org"];
        extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
      };

      home-manager.users.dastarruer = {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        programs.noctalia = {
          enable = true;
          systemd.enable = true;

          settings = {
            # The following settings are disabled here, but can be enabled through the custom options
            wallpaper.enabled = lib.mkDefault false;
            nightlight.enabled = lib.mkDefault false;
            lockscreen.enabled = lib.mkDefault false;
            notification.enable_daemon = lib.mkDefault false;

            # I don't need this
            calendar.enabled = false;
            weather.enabled = false;

            ui = {
              font_family = fonts.monospace.name;
            };

            bar = {
              order = ["default"];
              default = {
                enabled = true;

                position = "top";
                auto_hide = false;
                reserve_space = true;
                layer = "top";

                thickness = 34;
                scale = 1.05;
                background_opacity = "1.0";
                radius = 0;
                capsule_radius = 0;
                icon_color = "#${config.custom.theme.accent}";
                margin_ends = 0;
                margin_edge = 0;
                padding = 24;
                widget_spacing = 13;

                start = [
                  "caffeine"
                  "workspaces"
                  "ram"
                  "cpu"
                ];
                center = ["clock"];
                end = [
                  "keyboard_layout"
                  "volume"
                  "battery"
                  "brightness"
                  "network"
                  "bluetooth"
                ];
              };
            };

            widget = {
              clock.format = "%I:%M %A, %b %d";
              workspaces = with colors.withHashtag; {
                occupied_color = base00;
                empty_color = base00;
              };
            };

            # Since stylix does not support v5 yet, configure theme manually
            theme = {
              mode = "dark";
              source = "custom";
              custom_palette = "Custom";
            };
          };
        };

        # I think I have to manually write the json file for now
        home.file.".config/noctalia/palettes/Custom.json".text = builtins.toJSON {
          dark = with colors.withHashtag; {
            mPrimary = "#${config.custom.theme.accent}";
            mOnPrimary = base00;
            mSecondary = base0E;
            mOnSecondary = base00;
            mTertiary = base0C;
            mOnTertiary = base00;
            mError = base08;
            mOnError = base00;
            mSurface = base00;
            mOnSurface = base05;
            mSurfaceVariant = base01;
            mOnSurfaceVariant = base04;
            mOutline = base03;
            mShadow = base00;
            mHover = base02;
            mOnHover = base05;
            terminal = {
              background = base00;
              foreground = base05;
              cursor = base05;
              cursorText = base00;
              selectionBg = base05;
              selectionFg = base00;
            };
            normal = {
              black = base00;
              red = base08;
              green = base0B;
              yellow = base0A;
              blue = base0D;
              magenta = base0E;
              cyan = base0C;
              white = base05;
            };
            bright = {
              black = base03;
              red = base08;
              green = base0B;
              yellow = base0A;
              blue = base0D;
              magenta = base0E;
              cyan = base0C;
              white = base07;
            };
          };
        };
      };
    };
}
