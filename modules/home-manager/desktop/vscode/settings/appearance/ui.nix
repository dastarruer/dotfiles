{config, ...}: let
    profile = config.home-manager.desktop.vscode.profile;
in {
  # UI Layout & Navigation
  programs.vscode.profiles.${profile}.userSettings = {
    "workbench.sideBar.location" = "right";
    "workbench.activityBar.location" = "top";
    # "workbench.statusBar.visible" = false;
    "workbench.editor.showTabs" = "single";
    "workbench.startupEditor" = "none";
    "workbench.tips.enabled" = false;
    "breadcrumbs.enable" = false;
    "workbench.tree.renderIndentGuides" = "onHover";
    "workbench.tree.indent" = 16;
    "explorer.decorations.badges" = false;
    "window.menuBarVisibility" = "hidden";
  };
}
