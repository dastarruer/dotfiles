{...}: {
  flake.nixosModules.desktop_firefox = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;
  in {
    options.custom = {
      desktop.firefox = {
        profile = lib.mkOption {
          type = lib.types.str;
          default = "default";
          description = "Name of the default profile.";
        };
        deckFixes = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Apply Steam Deck specific Firefox settings.";
        };
      };
    };

    config.home-manager.users.dastarruer = {
      # Necessary for gdocs to render fonts properly
      home.packages = [pkgs.corefonts];

      # Supposedly, configPath is supposed to set the firefox config path... but it doesn't
      # This is a workaround so i don't go crazy
      systemd.user.tmpfiles.rules = [
        "L+ %h/.mozilla - - - - ${hmConfig.xdg.configHome}/mozilla"
      ];

      programs.firefox = {
        enable = true;
        package = pkgs.firefox-bin;
        configPath = "${hmConfig.xdg.configHome}/mozilla/firefox";

        profiles."${config.custom.desktop.firefox.profile}" = {
          id = 0;
          name = "${config.custom.desktop.firefox.profile}";
          isDefault = true;
        };
      };

      # Windowrules for picture-in-picture
      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        window_rule = [
          {
            match.title = "Picture-in-Picture";
            float = true;
            move = lib.generators.mkLuaInline "{3408, 834}";
            size = lib.generators.mkLuaInline "{427, 240}";
            pin = true;
          }
        ];
      };
    };
  };
}
