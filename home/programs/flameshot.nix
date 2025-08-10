{
  pkgs,
  config,
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
      };
    };
  };

  # Hide the flameshot wayland warning (https://github.com/flameshot-org/flameshot/issues/3186)
  services.dunst.settings.ignore_flameshot_warning = {
    body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
    format = "";
  };

  # Flameshot rules (https://wiki.hypr.land/FAQ/#:~:text=Option%203%3A%20Install%20flameshot%2E)
  wayland.windowManager.hyprland.settings.windowrule = [
    "noanim, class:^(flameshot)$"
    "float, class:^(flameshot)$"
    "move 0 0, class:^(flameshot)$"
    "pin, class:^(flameshot)$"
    "noinitialfocus, class:^(flameshot)$"
  ];
}
