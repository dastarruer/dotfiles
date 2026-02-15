{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
  dunst = config.home-manager.window-manager.dunst;
in {
  options = {
    home-manager.desktop.flameshot.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable && !hyprland.enable;
      description = "Enable flameshot. Defaults to false if Hyprland is enabled.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.flameshot.enable {
    assertions = [
      {
        assertion = !hyprland.enable;
        message = "hyprland cannot be enabled at the same time as flameshot, since hyprland uses grim + slurp for screenshots. Flameshot is also worse on wayland.";
      }
    ];
    services.flameshot = {
      enable = true;

      # Enable wayland support with this build flag
      # Yes there's an assertion but if i ever remove that then it's better to have this here
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

    # Same comment as above; might as well keep this
    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "no_anim on, match:title flameshot"
        "float on, match:title flameshot"
        "move 0 0, match:title flameshot"
        "pin on, match:title flameshot"
        "no_initial_focus on, match:title flameshot"
        "monitor 1, class:flameshot"
      ];
    };
  };
}
