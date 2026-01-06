{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  options = {
    home-manager.desktop.zathura.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enableAll;
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
      windowrulev2 = [
        "idleinhibit focus, class:^(org.pwmt.zathura)$"
      ];
    };
  };
}
