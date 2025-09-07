{
  pkgs,
  config,
  lib,
  ...
}: let
  # Icon-related settings
  iconPackage = pkgs.papirus-icon-theme;
  iconName = "Papirus-Dark";

  # Font-related settings
  fontPackage = config.stylix.fonts.sansSerif.package;
  fontName = "${config.stylix.fonts.sansSerif.name}";
  fontSize = 12;

  # Cursor-related settings
  cursorPackage = config.stylix.cursor.package;
  cursorName = "${config.stylix.cursor.name}";
  cursorSize = config.stylix.cursor.size;
in {
  gtk = {
    enable = true;

    # Theme
    theme = {
      package = lib.mkDefault pkgs.gruvbox-gtk-theme;
      name = lib.mkDefault "Gruvbox-Dark";
    };
    gtk2.theme = {
      package = lib.mkDefault pkgs.gruvbox-gtk-theme;
      name = lib.mkDefault "Gruvbox-Dark";
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

  specialisation.catppuccin.configuration.gtk = {
    # Theme
    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-Dark";
    };
    gtk2.theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-Dark";
    };
  };
}
