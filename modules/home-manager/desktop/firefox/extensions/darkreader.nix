{
  config,
  firefoxAddonPkgs,
  ...
}: let
  # While the default is Dynamic theme generation (looks the best), it slows down some sites too much. This function instead sets a site-specific preset that uses the SVG filter engine, which is much faster but less accurate.
  mkFilterPlusPreset = urls: {
    url = urls;
    theme = {
      mode = 1;
      brightness = 100;
      contrast = 100;
      grayscale = 0;
      sepia = 0;
      useFont = true;
      fontFamily = config.stylix.fonts.sansSerif.name;
      textStroke = 0;
      engine = "svgFilter";
      stylesheet = "";
      darkSchemeBackgroundColor = "#${config.lib.stylix.colors.base00}";
      darkSchemeTextColor = "#${config.lib.stylix.colors.base05}";
      lightSchemeBackgroundColor = "#${config.lib.stylix.colors.base05}";
      lightSchemeTextColor = "#${config.lib.stylix.colors.base00}";
      scrollbarColor = "auto";
      selectionColor = "auto";
      styleSystemControls = false;
      lightColorScheme = "Default";
      darkColorScheme = "Default";
      immediateModify = false;
    };
  };
in {
  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}".extensions = {
    packages = with firefoxAddonPkgs; [
      darkreader
    ];

    settings."addon@darkreader.org" = {
      force = true;

      settings = {
        schemeVersion = 2;
        enabled = true;
        fetchNews = true;
        theme = {
          mode = 1;
          brightness = 100;
          contrast = 100;
          grayscale = 0;
          sepia = 0;
          useFont = true;
          ontFamily = "${config.stylix.fonts.sansSerif.name}";
          textStroke = 0;
          engine = "dynamicTheme";
          stylesheet = "";
          darkSchemeBackgroundColor = "#${config.lib.stylix.colors.base00}";
          darkSchemeTextColor = "#${config.lib.stylix.colors.base05}";
          lightSchemeBackgroundColor = "#${config.lib.stylix.colors.base05}";
          lightSchemeTextColor = "#${config.lib.stylix.colors.base00}";
          scrollbarColor = "auto";
          selectionColor = "auto";
          styleSystemControls = false;
          lightColorScheme = "Default";
          darkColorScheme = "Default";
          immediateModify = false;
        };
        presets = [
          (mkFilterPlusPreset [
            "ispsedu.schoology.com"
            "mail.google.com"
            "docs.google.com"
            "spreadsheets.google.com"
            "apclassroom.collegeboard.org"
          ])
        ];
        customThemes = [];
        enabledByDefault = true;
        enabledFor = [];
        disabledFor = [
          "coolors.co"
          "learning.amplify.com"
          "student.amplify.com"
          "isps.powerschool.com"
          "127.0.0.1"
          "apps.youscience.com"
          "wvs.agilixbuzz.com"
          "172.18.0.3"
          "notebooklm.google.com"
          "gemini.google.com"
          "nidhiupman568.github.io"
          "runestone.academy"
          "www.healthcentral.com"
          "en.wikipedia.org"
          "localhost"
          "disney.fandom.com"
          "www.gamespot.com"
          "wiki.deckbrew.xyz"
          "decky.net"
          "www.figma.com"
          "read.amazon.in"
          "archive.org"
          "wikipedia25.org"
          "svgcolor.com"
          "www.canva.com"
          "youtube.com"
          "github.com"
        ];
        changeBrowserTheme = false;
        syncSettings = false;
        syncSitesFixes = true;
        automation = {
          enabled = false;
          mode = "system";
          behavior = "OnOff";
        };
        time = {
          activation = "18:00";
          deactivation = "9:00";
        };
        location = {
          latitude = null;
          longitude = null;
        };
        previewNewDesign = true;
        enableForPDF = true;
        enableForProtectedPages = true;
        enableContextMenus = false;
        detectDarkTheme = true;
        displayedNews = [
          "thanks-2023"
        ];
      };
    };
  };
}
