{config, ...}: {
  # Configure font
  programs.vscode.profiles.default.userSettings = {
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
    "editor.fontSize" = config.stylix.fonts.sizes.terminal;

    # Make comments italicized
    "editor.tokenColorCustomizations" = {
      "textMateRules" = [
        {
          "scope" = "comment";
          "settings" = {
            "fontStyle" = "italic";
          };
        }
      ];
    };
  };
}
