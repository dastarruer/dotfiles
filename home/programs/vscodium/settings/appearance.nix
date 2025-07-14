{...}: {
  # Define appearance related settings here
  programs.vscode.profiles.default.userSettings = {
    # UI
    "workbench.sideBar.location" = "right";
    "workbench.activityBar.location" = "hidden";
    "workbench.statusBar.visible" = false;
    "workbench.editor.showTabs" = "single";
    "workbench.startupEditor" = "none";
    "workbench.tips.enabled" = false;
    "breadcrumbs.enable" = false;
    "workbench.tree.renderIndentGuides" = false;
    "workbench.tree.indent" = 16;
    "explorer.decorations.badges" = false;
    "editor.lightbuld.enabled" = "off";
    "editor.guides.indentation" = false;
    "editor.scrollbar.vertical" = "hidden";
    "editor.scrollbar.horizontal" = "hidden";
    "editor.overviewRulerBorder" = false;
    "editor.hideCursorInOverviewRuler" = true;
    "editor.minimap.enabled" = false;
    "workbench.colorCustomizations" = {
      "editorOverviewRuler.wordHighlightStrongForeground" = "#0000";
      "editorOverviewRuler.selectionHighlightForeground" = "#0000";
      "editorOverviewRuler.rangeHighlightForeground" = "#0000";
      "editorOverviewRuler.wordHighlightForeground" = "#0000";
      "editorOverviewRuler.bracketMatchForeground" = "#0000";
      "editorOverviewRuler.findMatchForeground" = "#0000";
      "editorOverviewRuler.modifiedForeground" = "#0000";
      "editorOverviewRuler.deletedForeground" = "#0000";
      "editorOverviewRuler.warningForeground" = "#0000";
      "editorOverviewRuler.addedForeground" = "#0000";
      # "editorOverviewRuler.errorForeground" = "#0000";
      "editorOverviewRuler.infoForeground" = "#0000";
      "editorOverviewRuler.border" = "#0000";
    };

    # Appearance
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.colorTheme" = "Gruvbox Dark Medium";
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Fira code', monospace";
    "editor.fontSize" = "15";
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
