# Note that custom themes can come from here: https://github.com/Gerg-L/spicetify-nix/blob/master/pkgs/themes.nix
{
  config,
  spicePkgs,
  ...
}: {
  # Spicetify themes
  programs.spicetify = {
    theme = spicePkgs.themes.text;

    # Change the font to the stylix font
    enabledSnippets = [
      "* {
           font-family: \"${config.stylix.fonts.serif.name}\" !important
       }"
    ];

    # Colors can be found here: https://github.com/AvinashReddy3108/spicetify-tui/blob/master/tui/color.ini
    # Style guide here: https://github.com/chriskempson/base16/blob/main/styling.md
    customColorScheme = {
      accent = "${config.lib.stylix.colors.base09}";
      accent-active = "${config.lib.stylix.colors.base09}";
      accent-inactive = "${config.lib.stylix.colors.base00}";
      banner = "${config.lib.stylix.colors.base09}";
      border-active = "${config.lib.stylix.colors.base05}";
      border-inactive = "${config.lib.stylix.colors.base03}";
      header = "${config.lib.stylix.colors.base03}";
      highlight = "${config.lib.stylix.colors.base01}";
      main = "${config.lib.stylix.colors.base00}";
      notification = "${config.lib.stylix.colors.base09}";
      notification-error = "${config.lib.stylix.colors.base08}";
      subtext = "${config.lib.stylix.colors.base04}";
      text = "${config.lib.stylix.colors.base05}";
    };

    # Colors can be found here: https://github.com/riasat-sheikh/Onepunch/blob/main/color.ini
    # Old onepunch color scheme
    # customColorScheme = {
    #   text = "${config.lib.stylix.colors.base05}";
    #   subtext = "${config.lib.stylix.colors.base04}";
    #   extratext = "${config.lib.stylix.colors.base0A}";
    #   main = "${config.lib.stylix.colors.base00}";
    #   sidebar = "${config.lib.stylix.colors.base00}";
    #   player = "${config.lib.stylix.colors.base00}";
    #   sec-player = "${config.lib.stylix.colors.base00}";
    #   card = "${config.lib.stylix.colors.base01}";
    #   sec-card = "${config.lib.stylix.colors.base08}";
    #   shadow = "${config.lib.stylix.colors.base00}";
    #   selected-row = "${config.lib.stylix.colors.base05}";
    #   button = "${config.lib.stylix.colors.base09}";
    #   button-active = "${config.lib.stylix.colors.base09}";
    #   button-disabled = "${config.lib.stylix.colors.base05}";
    #   tab-active = "${config.lib.stylix.colors.base08}";
    #   notification = "${config.lib.stylix.colors.base09}";
    #   notification-error = "${config.lib.stylix.colors.base08}";
    #   misc = "${config.lib.stylix.colors.base0D}";
    # };
  };
}
