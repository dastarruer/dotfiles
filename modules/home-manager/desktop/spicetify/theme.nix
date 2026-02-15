# Note that custom themes can come from here: https://github.com/Gerg-L/spicetify-nix/blob/master/pkgs/themes.nix
{
  config,
  spicePkgs,
  ...
}: {
  # Spicetify themes
  programs.spicetify = {
    theme = spicePkgs.themes.text;

    enabledSnippets = [
      # Change the font to the stylix font
      ''
         * {
            font-family: "${config.stylix.fonts.serif.name}", monospace !important
        }
      ''
      # Remove borders
      ''
        :root {
           --border-width: 0px !important
        }
      ''
      # Remove headers (e.g. nav, library, sidebar, etc.)
      # Doesn't seem to work for every header though; nav and sidebar headers still show
      ''
        .Root__nav-bar .main-yourLibraryX-entryPoints:nth-child(1)::before {
            content: "" !important;
        }

        .Root__nav-bar .main-yourLibraryX-entryPoints:nth-child(2)::before {
            content: "" !important;
        }

        .Root__main-view::before {
            content: "" !important;
        }

        .Root__now-playing-bar::before {
            content: "" !important;
        }

        .Root__right-sidebar > section:not(:empty)::before {
            content: "" !important;
        }
      ''
    ];

    # Colors can be found here: https://github.com/AvinashReddy3108/spicetify-tui/blob/master/tui/color.ini
    # Style guide here: https://github.com/chriskempson/base16/blob/main/styling.md
    customColorScheme = {
      accent = "${config.home-manager.theme.accent}";
      accent-active = "${config.home-manager.theme.accent}";
      accent-inactive = "${config.lib.stylix.colors.base00}";
      banner = "${config.home-manager.theme.accent}";
      border-active = "${config.lib.stylix.colors.base05}";
      border-inactive = "${config.lib.stylix.colors.base03}";
      header = "${config.lib.stylix.colors.base03}";
      highlight = "${config.lib.stylix.colors.base01}";
      main = "${config.lib.stylix.colors.base00}";
      notification = "${config.home-manager.theme.accent}";
      notification-error = "${config.lib.stylix.colors.base08}";
      subtext = "${config.lib.stylix.colors.base04}";
      text = "${config.lib.stylix.colors.base05}";
    };

    # Colors can be found here: https://github.com/riasat-sheikh/Onepunch/blob/main/color.ini
    # Old onepunch color scheme
    # customColorScheme = {
    #   text = "${config.lib.stylix.colors.base05}";
    #   subtext = "${config.lib.stylix.colors.base04}";
    #   extratext = "${config.lib.stylix.colors.base0A}";
    #   main = "${config.lib.stylix.colors.base00}";
    #   sidebar = "${config.lib.stylix.colors.base00}";
    #   player = "${config.lib.stylix.colors.base00}";
    #   sec-player = "${config.lib.stylix.colors.base00}";
    #   card = "${config.lib.stylix.colors.base01}";
    #   sec-card = "${config.lib.stylix.colors.base08}";
    #   shadow = "${config.lib.stylix.colors.base00}";
    #   selected-row = "${config.lib.stylix.colors.base05}";
    #   button = "${config.home-manager.theme.accent}";
    #   button-active = "${config.home-manager.theme.accent}";
    #   button-disabled = "${config.lib.stylix.colors.base05}";
    #   tab-active = "${config.lib.stylix.colors.base08}";
    #   notification = "${config.home-manager.theme.accent}";
    #   notification-error = "${config.lib.stylix.colors.base08}";
    #   misc = "${config.lib.stylix.colors.base0D}";
    # };
  };
}
