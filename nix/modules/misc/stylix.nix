{pkgs, ...}: let
  theme = "gruvbox-dark-hard";
in {
  stylix = {
    enable = true;

    # Set the color theme
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    image = ../../../wallpapers/gruvbox/1022291.jpg;

    # Disable targets
    targets.plymouth.enable = false;

    # Cursor settings
    cursor.package = pkgs.capitaine-cursors-themed;
    cursor.name = "Capitaine Cursors (Gruvbox)";
    cursor.size = 24;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 12;
        popups = 12;
      };
    };
  };
}
