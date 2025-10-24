{
  spicePkgs,
  config,
  lib,
  ...
}: {
  # Spicetify themes
  programs.spicetify = {
    theme = {
      name = spicePkgs.themes.onepunch;
      additionalCss =
        lib.concatStringsSep "\n" [
          "*{
         font-family: \"<font>\" !important
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
