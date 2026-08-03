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
      home-manager.users.dastarruer = {
        services.flameshot = {
          enable = true;

          # Enable wayland support with this build flag
          package = lib.mkIf wayland pkgs.flameshot.override {
            enableWlrSupport = true;
          };

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

              # For wayland
              useGrimAdapter = true;
              disabledGrimWarning = true;
            };
          };
        };

        # Hide the flameshot wayland warning (https://github.com/flameshot-org/flameshot/issues/3186)
        services.dunst.settings.ignore_flameshot_warning = lib.mkIf dunst.enable {
          body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
          format = "";
        };

        home-manager.window-manager.notifications.excludeTitles = ["flameshot"];

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
          window_rule = [
            {
              match.title = "flameshot";
              no_anim = true;
              float = true;
              move = lib.generators.mkLuaInline "{0, 0}";
              pin = true;
              no_initial_focus = true;
              monitor = 1;
            }
          ];
        };
      };
    };
}
