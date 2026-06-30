{...}: {
  flake.nixosModules.desktop_browser = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    profile = config.custom.desktop.browser.profile;
    hyprland = config.custom.wm.wm == "hyprland";
    browser = config.custom.desktop.browser.kind;
  in
    lib.mkIf (browser == "firefox") {
      home-manager.users.dastarruer = {
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

          profiles."${profile}" = {
            id = 0;
            name = "${profile}";
            isDefault = true;
          };
        };

        # Windowrules for picture-in-picture
        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
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
