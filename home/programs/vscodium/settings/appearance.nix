{...}: {
  # Define appearance related settings here
  programs.vscode.profiles.default.userSettings = {
    # UI
    "workbench.sideBar.location" = "right";
    "workbench.activityBar.location" = "top";
    "workbench.statusBar.visible" = false;
    "editor.minimap.enabled" = false;

    # Appearance
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.colorTheme" = "Gruvbox Dark Medium";
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Fira code', monospace";
    "editor.fontSize" = "15";
  };
}
