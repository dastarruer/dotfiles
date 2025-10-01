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
      };
    };
  };

  # Create the save dir for flameshot
  home.activation.createSavePath = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/Pictures/screenshots"
  '';

  # Hide the flameshot wayland warning (https://github.com/flameshot-org/flameshot/issues/3186)
  services.dunst.settings.ignore_flameshot_warning = {
    body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
    format = "";
  };
}
