{...}: {
  # Configure font
  programs.vscode.profiles.default.userSettings = {
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Fira code', monospace";
    "editor.fontSize" = 15;

    # Make comments italicized
    "editor.tokenColorCustomizations" = {
      "textMateRules" = {
        "scope" = "comment";
        "settings" = {
          "fontStyle" = "italic";
        };
      };
    };
  };
}
