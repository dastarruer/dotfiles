{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
  dunst = config.home-manager.window-manager.dunst;
in {
  options = {
    home-manager.desktop.flameshot.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enableAll;
      description = "Enable flameshot, a screenshot tool. Will be disabled by default if home-manager.window-manager.hyprland.enable is set to true.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.flameshot.enable {
    services.flameshot = {
      enable = true;

      # Enable wayland support with this build flag
      package = lib.mkIf hyprland.enable pkgs.flameshot.override {
        enableWlrSupport = true;
      };

      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;

          # Auto save to this path
          savePath = "${config.home.sessionVariables.XDG_SCREENSHOTS_DIR}";
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

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "noanim, title:^(flameshot)$"
        "float, title:^(flameshot)$"
        "move 0 0, title:^(flameshot)$"
        "pin, title:^(flameshot)$"
        "noinitialfocus, title:^(flameshot)$"
        "monitor 1, class:^(flameshot)$"
      ];
    };
  };
}
