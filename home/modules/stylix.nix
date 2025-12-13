{pkgs, ...}: {
  stylix = {
    enable = true;

    # Set the color theme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";

    # Disable stylix configuration for certain apps
    targets = {
      # Note that these requires manual theming
      vscode.enable = false;
      gtk.enable = false;

      # These are fine
      hyprland.enable = false;
      hyprlock.enable = false;
      anki.enable = false;
      spicetify.enable = false;
      waybar.enable = false;
      dunst.enable = false;
      rofi.enable = false;
    };

    # Cursor settings
    cursor = {
      package = pkgs.bibata-cursors;
      size = 24;

      # To find the cursor name: ls ~/.nix-profile/share/icons
      name = "Bibata-Modern-Classic";
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
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
