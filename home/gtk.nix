{
  pkgs,
  lib,
  ...
}: let
  # Font-related settings
  fontPackage = pkgs.noto-fonts;
  fontName = "Noto Sans 12";

  # Cursor-related settings
  cursorPackage = pkgs.capitaine-cursors-themed;
  cursorName = "Capitaine Cursors (Gruvbox)";
  cursorSize = 24;
in {
  gtk = {
    enable = true;

    # Font
    font = {
      package = fontPackage;
      name = fontName;
    };
    gtk2.font = {
      package = fontPackage;
      name = fontName;
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

  # chatgpt told me to use this to prevent conflicts and it works so
  dconf.settings."org/gnome/desktop/interface".font-name =
    lib.mkForce fontName;
}
