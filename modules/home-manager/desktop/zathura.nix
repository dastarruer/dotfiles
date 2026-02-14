{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
in {
  options = {
    home-manager.desktop.zathura.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable zathura, a PDF reader.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.zathura.enable {
    programs.zathura = {
      enable = true;

      options = {
        # Set dark mode by default
        recolor = true;

        # Fill window upon opening
        adjust_window = "best-fit";
        adjust_open = "best-fit";

        window-title-home-tilde = true;
        statusbar-basename = true;
        selection-clipboard = "clipboard";
        restore-session = true;
      };
    };

    # Set zathura as default pdf viewer
    xdg.mimeApps.defaultApplications."application/pdf" = ["org.pwmt.zathura.desktop"];

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "idle_inhibit focus, match:class org.pwmt.zathura"
      ];
    };
  };
}
