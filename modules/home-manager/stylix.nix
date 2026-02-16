{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.theme = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "default-dark";
        description = "Base-16 theme to use. See https://github.com/tinted-theming/schemes for available themes.";
      };
      accent = lib.mkOption {
        type = lib.types.str;
        default = config.lib.stylix.colors.base09;
        description = "Base-16 accent color to use.";
      };
    };
  };

  config = {
    stylix = {
      enable = true;

      # Set the color theme
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.home-manager.theme.name}.yaml";

      # Disable stylix configuration for certain apps
      targets = {
        # These are fine
        vscode.enable = false;
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

      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
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
  };
}
