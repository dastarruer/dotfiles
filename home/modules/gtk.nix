{
  pkgs,
  config,
  ...
}: let
  # Theme-related settings
  themePackage = pkgs.gruvbox-gtk-theme;
  themeName = "Gruvbox-Dark";

  # Icon-related settings
  iconPackage = pkgs.papirus-icon-theme;
  iconName = "Papirus-Dark";

  # Font-related settings
  fontPackage = config.stylix.fonts.sansSerif.package;
  fontName = "${config.stylix.fonts.sansSerif.name}";
  fontSize = 12;

  # Cursor-related settings
  cursorPackage = pkgs.capitaine-cursors-themed;
  cursorName = "Capitaine Cursors (Gruvbox)";
  cursorSize = 24;
in {
  gtk = {
    enable = true;

    # Theme
    theme = {
      package = themePackage;
      name = themeName;
    };
    gtk2.theme = {
      package = themePackage;
      name = themeName;
    };

    # Icons
    iconTheme = {
      package = iconPackage;
      name = iconName;
    };
    gtk2.iconTheme = {
      package = iconPackage;
      name = iconName;
    };

    # Font
    font = {
      package = fontPackage;
      name = fontName;
      size = fontSize;
    };
    gtk2.font = {
      package = fontPackage;
      name = fontName;
      size = fontSize;
    };

    # Cursors
    cursorTheme = {
      package = cursorPackage;
      name = cursorName;
      size = cursorSize;
    };
    gtk2.cursorTheme = {
      package = cursorPackage;
      name = cursorName;
      size = cursorSize;
    };
  };
}
