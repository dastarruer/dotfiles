{
  config,
  lib,
  ...
}: let
  # Define the list of image mimetypes to associate with imv
  imageMimes = [
    "image/bmp"
    "image/gif"
    "image/jpeg"
    "image/jpg"
    "image/pjpeg"
    "image/png"
    "image/tiff"
    "image/x-bmp"
    "image/x-pcx"
    "image/x-png"
    "image/x-portable-anymap"
    "image/x-portable-bitmap"
    "image/x-portable-graymap"
    "image/x-portable-pixmap"
    "image/x-tga"
    "image/x-xbitmap"
    "image/heic"
    "image/avif"
    "image/webp"
  ];
in {
  options = {
    home-manager.desktop.imv.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable imv, an image viewer.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.imv.enable {
    programs.imv = {
      enable = true;
      settings = {
        options.background = "${config.lib.stylix.colors.base00}";
        aliases.q = "close";
        aliases.r = "rotate by 90";
      };
    };

    # Set as default for all common image types
    xdg.mimeApps.defaultApplications =
      lib.genAttrs imageMimes (_: "imv.desktop");
  };
}
