{config, ...}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  # Editor Display & Visuals
  programs.vscode.profiles.${profile}.userSettings = {
    "editor.lightbulb.enabled" = "off";
    "editor.guides.indentation" = false;
    "editor.scrollbar.vertical" = "auto";
    "editor.scrollbar.horizontal" = "hidden";
    "editor.overviewRulerBorder" = false;
    "editor.hideCursorInOverviewRuler" = true;
    "editor.stickyScroll.enabled" = false;
    "editor.minimap.enabled" = false;
  };
}
