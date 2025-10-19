{pkgs, ...}: {
  stylix = {
    enable = true;

    # Set the color theme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-gorgoroth.yaml";

    # Cursor settings
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata Modern Classic";
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
