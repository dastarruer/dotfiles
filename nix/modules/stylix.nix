{
  pkgs,
  lib,
  ...
}: {
  specialisation.catppuccin.configuration = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      cursor = {
        package = pkgs.catppuccin-cursors;
        name = "mochaMauve";
      };
    };
  };

  stylix = {
    enable = true;

    # Set the color theme
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    # Disable targets
    targets.plymouth.enable = false;

    # Cursor settings
    cursor.package = lib.mkDefault pkgs.capitaine-cursors-themed;
    cursor.name = lib.mkDefault "Capitaine Cursors (Gruvbox)";
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
