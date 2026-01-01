{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.whatsapp.enable = lib.mkEnableOption "Enable WhatsApp PWA. NOTE: THIS DOES NOT WORK AS OF NOW. ENABLING DOES NOTHING";
  };

  config = lib.mkIf config.myPrograms.whatsapp.enable {
    programs.firefoxpwa.profiles.default.sites.whatsapp.settings = {
      config = {
        name = "WhatsApp";
        start_url = "https://web.whatsapp.com/";
        icon_url = "https://web.whatsapp.com/img/favicon/1x/favicon.png";
      };
    };
  };
}
