{
  pkgs,
  config,
  lib,
  ...
}: {
  # Spicetify themes
  programs.spicetify = {
    theme = {
      name = "Onepunch";

      src = pkgs.fetchFromGitHub {
        owner = "riasat-sheikh";
        repo = "Onepunch";
        rev = "98034712add505ae513b118b94b6d18bba25b3cd";
        hash = "sha256-nGxMc9mtshWsCQS8B/dPNXXlWeFM58HvWmp7Aj2/V2c=";
      };

      additionalCss = lib.concatStringsSep "\n" [
        # Change the font to the stylix font
        "* {
              font-family: \"${config.stylix.fonts.serif.name}\" !important
         }"
      ];
    };

    customColorScheme = {
      # More vivid accents & UI highlights
      accent = "${config.lib.stylix.colors.base0C}";
      accentActive = "${config.lib.stylix.colors.base0D}";
      accentInactive = "${config.lib.stylix.colors.base03}";
      banner = "${config.lib.stylix.colors.base0A}";
      borderActive = "${config.lib.stylix.colors.base08}";
      borderInactive = "${config.lib.stylix.colors.base01}";
      header = "${config.lib.stylix.colors.base0E}";
      highlight = "${config.lib.stylix.colors.base0B}";

      # Background-based elements (restored to original muted tone)
      main = "${config.lib.stylix.colors.base00}";
      sidebar = "${config.lib.stylix.colors.base00}";
      player = "${config.lib.stylix.colors.base00}";
      secPlayer = "${config.lib.stylix.colors.base04}";
      card = "${config.lib.stylix.colors.base02}";
      secCard = "${config.lib.stylix.colors.base03}";
      shadow = "${config.lib.stylix.colors.base01}";
      selectedRow = "${config.lib.stylix.colors.base02}";

      # Text & UI
      text = "${config.lib.stylix.colors.base05}";
      subtext = "${config.lib.stylix.colors.base05}";
      extratext = "${config.lib.stylix.colors.base05}";
      defaultFgColor = "${config.lib.stylix.colors.base05}";

      # Buttons (vivid upgrades retained)
      button = "${config.lib.stylix.colors.base0D}";
      buttonActive = "${config.lib.stylix.colors.base0B}";
      buttonDisabled = "${config.lib.stylix.colors.base01}";

      # Tabs and misc
      tabActive = "${config.lib.stylix.colors.base0E}";
      misc = "${config.lib.stylix.colors.base03}";

      # Notifications
      notification = "${config.lib.stylix.colors.base09}";
      notificationError = "${config.lib.stylix.colors.base08}";
    };
  };
}
