{
  pkgs,
  config,
  lib,
  ...
}: {
  services.flameshot = {
    enable = true;

    # Enable wayland support with this build flag
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
    };

    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;

        # Auto save to this path
        savePath = "${config.home.homeDirectory}/Pictures/screenshots";
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
  services.dunst.settings.ignore_flameshot_warning = {
    body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
    format = "";
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "noanim, title:^(flameshot)$"
      "float, title:^(flameshot)$"
      "move 0 0, title:^(flameshot)$"
      "pin, title:^(flameshot)$"
      "noinitialfocus, title:^(flameshot)$"
      "monitor 1, class:^(flameshot)$"
    ];
  };
}
