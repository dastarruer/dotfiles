{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.calibre.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enableAll;
      description = "Enable calibre, an app for managing your book collection.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.calibre.enable {
    programs.calibre.enable = true;

    # Backup calibre library
    home-manager.cli.rclone.backupPaths = [
      "${config.home.homeDirectory}/Documents/calibre"
    ];

    # Style guide here: https://github.com/chriskempson/base16/blob/main/styling.md
    # Has to be applied manually with: Preferences -> Look and Feel -> Adjust colors -> Import
    home.file.".config/calibre/theme.calibre-palette".text = ''
      {
        "dark": {
          "palette": {
            "AlternateBase": "#${config.lib.stylix.colors.base00}",
            "Base": "#${config.lib.stylix.colors.base01}",
            "BrightText": "#${config.lib.stylix.colors.base01}",
            "BrightText-disabled": "#${config.lib.stylix.colors.base01}",
            "Button": "#${config.lib.stylix.colors.base00}",
            "ButtonText": "#${config.lib.stylix.colors.base05}",
            "ButtonText-disabled": "#${config.lib.stylix.colors.base04}",
            "Highlight": "#${config.lib.stylix.colors.base09}",
            "HighlightedText": "#${config.lib.stylix.colors.base01}",
            "HighlightedText-disabled": "#${config.lib.stylix.colors.base01}",
            "Link": "#${config.lib.stylix.colors.base08}",
            "LinkVisited": "#${config.lib.stylix.colors.base0E}",
            "PlaceholderText": "#${config.lib.stylix.colors.base05}",
            "PlaceholderText-disabled": "#${config.lib.stylix.colors.base05}",
            "Text": "#${config.lib.stylix.colors.base05}",
            "Text-disabled": "#${config.lib.stylix.colors.base04}",
            "ToolTipBase": "#${config.lib.stylix.colors.base00}",
            "ToolTipText": "#${config.lib.stylix.colors.base05}",
            "ToolTipText-disabled": "#${config.lib.stylix.colors.base05}",
            "Window": "#${config.lib.stylix.colors.base00}",
            "WindowText": "#${config.lib.stylix.colors.base05}",
            "WindowText-disabled": "#${config.lib.stylix.colors.base04}"
          },
          "use_custom": true
        },
        "light": {
          "palette": {
            "AlternateBase": "#${config.lib.stylix.colors.base00}",
            "Base": "#${config.lib.stylix.colors.base01}",
            "BrightText": "#${config.lib.stylix.colors.base01}",
            "BrightText-disabled": "#${config.lib.stylix.colors.base01}",
            "Button": "#${config.lib.stylix.colors.base00}",
            "ButtonText": "#${config.lib.stylix.colors.base05}",
            "ButtonText-disabled": "#${config.lib.stylix.colors.base04}",
            "Highlight": "#${config.lib.stylix.colors.base09}",
            "HighlightedText": "#${config.lib.stylix.colors.base01}",
            "HighlightedText-disabled": "#${config.lib.stylix.colors.base01}",
            "Link": "#${config.lib.stylix.colors.base08}",
            "LinkVisited": "#${config.lib.stylix.colors.base0E}",
            "PlaceholderText": "#${config.lib.stylix.colors.base05}",
            "PlaceholderText-disabled": "#${config.lib.stylix.colors.base05}",
            "Text": "#${config.lib.stylix.colors.base05}",
            "Text-disabled": "#${config.lib.stylix.colors.base04}",
            "ToolTipBase": "#${config.lib.stylix.colors.base00}",
            "ToolTipText": "#${config.lib.stylix.colors.base05}",
            "ToolTipText-disabled": "#${config.lib.stylix.colors.base05}",
            "Window": "#${config.lib.stylix.colors.base00}",
            "WindowText": "#${config.lib.stylix.colors.base05}",
            "WindowText-disabled": "#${config.lib.stylix.colors.base04}"
          },
          "use_custom": false
        }
      }
    '';
  };
}
