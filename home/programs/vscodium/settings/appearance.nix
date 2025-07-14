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
    "editor.minimap.enabled" = false;

    # Appearance
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.colorTheme" = "Gruvbox Dark Medium";
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Fira code', monospace";
    "editor.fontSize" = "15";
  };
}
