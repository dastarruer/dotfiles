{...}: {
  programs.firefoxpwa.profiles.default.sites.whatsapp.settings = {
    config = {
      name = "WhatsApp";
      start_url = "https://web.whatsapp.com/";
      icon_url = "https://web.whatsapp.com/img/favicon/1x/favicon.png";
      desktopEntry = true;
    };
  };
}
