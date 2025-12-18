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

    # Colors can be found here: https://github.com/riasat-sheikh/Onepunch/blob/main/color.ini
    # Style guide here: https://github.com/chriskempson/base16/blob/main/styling.md
    customColorScheme = {
      text = "${config.lib.stylix.colors.base05}";
      subtext = "${config.lib.stylix.colors.base04}";
      extratext = "${config.lib.stylix.colors.base0A}";
      main = "${config.lib.stylix.colors.base00}";
      sidebar = "${config.lib.stylix.colors.base00}";
      player = "${config.lib.stylix.colors.base00}";
      sec-player = "${config.lib.stylix.colors.base00}";
      card = "${config.lib.stylix.colors.base01}";
      sec-card = "${config.lib.stylix.colors.base08}";
      shadow = "${config.lib.stylix.colors.base00}";
      selected-row = "${config.lib.stylix.colors.base05}";
      button = "${config.lib.stylix.colors.base09}";
      button-active = "${config.lib.stylix.colors.base09}";
      button-disabled = "${config.lib.stylix.colors.base05}";
      tab-active = "${config.lib.stylix.colors.base08}";
      notification = "${config.lib.stylix.colors.base09}";
      notification-error = "${config.lib.stylix.colors.base08}";
      misc = "${config.lib.stylix.colors.base0D}";
    };
  };
}
