{
  pkgs,
  lib,
  ...
}: let
  fontPackage = pkgs.noto-fonts;
  fontName = "Noto Sans 12";
in {
  gtk = {
    enable = true;

    font = {
      package = fontPackage;
      name = fontName;
    };
    gtk2.font = {
      package = fontPackage;
      name = fontName;
    };
  };

  # chatgpt told me to use this to prevent conflicts and it works so
  dconf.settings."org/gnome/desktop/interface".font-name =
    lib.mkForce fontName;
}
