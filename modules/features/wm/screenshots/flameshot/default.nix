{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    screenshot = config.custom.wm.screenshot.kind;
    hyprland = config.custom.wm.wm == "hyprland";
    wayland = config.custom.wm.wayland;
    dunst = config.services.dunst;
    screenshotPath = config.custom.wm.screenshot.path;
  in
    lib.mkIf (screenshot == "flameshot") {
      custom.wm.notifications.excludeTitles = ["flameshot"];
      home-manager.users.dastarruer = {
        services.flameshot = {
          enable = true;

          # Enable wayland support with this build flag
          package =
            if wayland
            then pkgs.flameshot.override {
              enableWlrSupport = true;
            }
            else pkgs.flameshot;

          settings = {
            General = {
              disabledTrayIcon = true;
              showStartupLaunchMessage = false;

              # Auto save to this path
              savePath = screenshotPath;
              savePathFixed = true;
              saveAsFileExtension = ".jpg";
              filenamePattern = "%F_%H-%M";
              drawThickness = 1;
              copyPathAfterSave = true;
            };
          };
        };

        # Hide the flameshot wayland warning (https://github.com/flameshot-org/flameshot/issues/3186)
        services.dunst.settings.ignore_flameshot_warning = lib.mkIf dunst.enable {
          body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
          format = "";
        };

        # https://github.com/flameshot-org/flameshot/blob/master/docs/UsageHyprlandSwayWlroots.md
        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            {
              _args = [
                "SUPER + P"
                (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe config.home-manager.users.dastarruer.services.flameshot.package} gui -c")'')
              ];
            }
          ];
          window_rule = [
            {
              match.class = "flameshot";
              no_anim = true;
              float = true;
              decorate = false;
              no_blur = true;
              no_shadow = true;
              pin = true;
            }
            {
              match = {
                class = "flameshot";
                title = "flameshot";
              };
              move = lib.generators.mkLuaInline "{0, 0}";
            }
            {
              match = {
                class = "flameshot";
                title = "flameshot-pin";
              };
              move = lib.generators.mkLuaInline "{\"cursor_x-(window_w*0.5)\", \"cursor_y-(window_h*0.5)\"}";
            }
          ];
        };
      };
    };
}
