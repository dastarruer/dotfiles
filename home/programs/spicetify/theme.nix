{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  # Spicetify themes
  programs.spicetify = {
    theme = {
      name = "Gruvify";
      src = pkgs.fetchFromGitHub {
        owner = "riasat-sheikh";
        repo = "Onepunch";
        rev = "main";
        sha256 = "sha256-nGxMc9mtshWsCQS8B/dPNXXlWeFM58HvWmp7Aj2/V2c=";
      };

      additionalCss = lib.concatStringsSep "\n" [
        ".main-rootview-container; .main-navBar-navBar; .main-topBar-container; .Root__nav-bar; .Root__top-bar {"
        "  background-color =  ${config.lib.stylix.colors.base00};"
        "}"

        ".main-view-container__scroll-node-child .main-entityHeader-container {"
        "  background-color =  ${config.lib.stylix.colors.base00};"
        "}"
      ];
    };

    customColorScheme = {
      accent = "${config.lib.stylix.colors.base00}";
      accentActive = "${config.lib.stylix.colors.base02}";
      accentInactive = "${config.lib.stylix.colors.base03}";
      banner = "${config.lib.stylix.colors.base04}";
      borderActive = "${config.lib.stylix.colors.base05}";
      borderInactive = "${config.lib.stylix.colors.base05}";
      header = "${config.lib.stylix.colors.base05}";
      highlight = "${config.lib.stylix.colors.base06}";
      main = "${config.lib.stylix.colors.base00}";
      notification = "${config.lib.stylix.colors.base07}";
      notificationError = "${config.lib.stylix.colors.base08}";
      subtext = "${config.lib.stylix.colors.base05}";
      text = "${config.lib.stylix.colors.base05}";
      extratext = "${config.lib.stylix.colors.base05}";
      sidebar = "${config.lib.stylix.colors.base00}";
      player = "${config.lib.stylix.colors.base04}";
      secPlayer = "${config.lib.stylix.colors.base04}";
      card = "${config.lib.stylix.colors.base02}";
      secCard = "${config.lib.stylix.colors.base03}";
      shadow = "${config.lib.stylix.colors.base01}";
      selectedRow = "${config.lib.stylix.colors.base02}";
      button = "${config.lib.stylix.colors.base04}";
      buttonActive = "${config.lib.stylix.colors.base05}";
      buttonDisabled = "${config.lib.stylix.colors.base01}";
      tabActive = "${config.lib.stylix.colors.base06}";
      misc = "${config.lib.stylix.colors.base03}";
      defaultFgColor = "${config.lib.stylix.colors.base05}";
    };
  };
}
# UNUSED
# programs.spicetify.theme = {
#   name = "Gruvify";
#   src = pkgs.fetchFromGitHub {
#     owner = "Skaytacium";
#     repo = "Gruvify";
#     rev = "main";
#     sha256 = "sha256-9kjoOd59c6/AUKQd0m+HVacrySZ+2JSGXK7Rb5IHH3o=";
#   };
# };

