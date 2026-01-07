{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.whatsapp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false; # Non-functional as of now
      description = "Enable WhatsApp PWA. NOTE: THIS DOES NOT WORK AS OF NOW. ENABLING DOES NOTHING.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.whatsapp.enable {
    programs.firefoxpwa.profiles.default.sites.whatsapp.settings = {
      config = {
        name = "WhatsApp";
        start_url = "https://web.whatsapp.com/";
        icon_url = "https://web.whatsapp.com/img/favicon/1x/favicon.png";
      };
    };
  };
}
