{
  pkgs,
  config,
  ...
}: {
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
        savePathFixed = true;
        saveAsFileExtension = ".jpg";
        filenamePattern = "%F_%H-%M";
        drawThickness = 1;
        copyPathAfterSave = true;
      };
      #   Shortcuts = {
      #  YPE_EXIT = "q";
      # };
    };
  };
}
