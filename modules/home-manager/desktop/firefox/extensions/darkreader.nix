{
  config,
  firefoxAddonPkgs,
  ...
}: {
  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}".extensions.packages = with firefoxAddonPkgs; [
    darkreader
  ];

  # Darkreader settings: https://github.com/darkreader/darkreader/issues/2168#issuecomment-2130219175
  # NOTE: You need to manually import this json file by going to extension settings -> Advanced -> Import settings, and select this file
  xdg.configFile.darkreader = {
    enable = true;
    target = "darkreader/config.json";
    text = ''
      {
          "schemeVersion": 2,
          "enabled": true,
          "fetchNews": true,
          "theme": {
             "mode": 1,
             "brightness": 100,
             "contrast": 100,
             "grayscale": 0,
             "sepia": 0,
             "useFont": false,
             fontFamily = "${config.stylix.fonts.sansSerif.name}",
             "textStroke": 0,
             "engine": "dynamicTheme",
             "stylesheet": "",
             "darkSchemeBackgroundColor": "#${config.lib.stylix.colors.base00}",
             "darkSchemeTextColor": "#${config.lib.stylix.colors.base05}",
             "lightSchemeBackgroundColor": "#${config.lib.stylix.colors.base05}",
             "lightSchemeTextColor": "#${config.lib.stylix.colors.base00}",
             "scrollbarColor": "auto",
             "selectionColor": "auto",
             "styleSystemControls": false,
             "lightColorScheme": "Default",
             "darkColorScheme": "Default",
             "immediateModify": false
          },
          "presets": [],
          "customThemes": [],
          "enabledByDefault": true,
          "enabledFor": [],
          "disabledFor": [],
          "changeBrowserTheme": false,
          "syncSettings": false,
          "syncSitesFixes": true,
          "automation": {
             "enabled": false,
             "mode": "",
             "behavior": "OnOff"
          },
          "time": {
             "activation": "18:00",
             "deactivation": "9:00"
          },
          "location": {
             "latitude": null,
             "longitude": null
          },
          "previewNewDesign": true,
          "enableForPDF": true,
          "enableForProtectedPages": true,
          "enableContextMenus": false,
          "detectDarkTheme": false,
          "displayedNews": [
             "thanks-2023"
          ]
      }
    '';
  };
}
