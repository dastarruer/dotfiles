{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.vscode.profiles.default = {
    # Extensions required for theming
    extensions = lib.mkDefault (with inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
      pkief.material-icon-theme
      jdinhlife.gruvbox
    ]);

    userSettings = lib.mkDefault {
      # Theme
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.colorTheme" = "Gruvbox Dark Hard";

      # Custom Colors
      "workbench.colorCustomizations" = {
        "editorOverviewRuler.wordHighlightStrongForeground" = "#0000";
        "editorOverviewRuler.selectionHighlightForeground" = "#0000";
        "editorOverviewRuler.rangeHighlightForeground" = "#0000";
        "editorOverviewRuler.wordHighlightForeground" = "#0000";
        "editorOverviewRuler.bracketMatchForeground" = "#0000";
        "editorOverviewRuler.findMatchForeground" = "#0000";
        "editorOverviewRuler.modifiedForeground" = "#0000";
        "editorOverviewRuler.deletedForeground" = "#0000";
        # "editorOverviewRuler.warningForeground" = "#0000";
        "editorOverviewRuler.addedForeground" = "#0000";
        # "editorOverviewRuler.errorForeground" = "#0000";
        "editorOverviewRuler.infoForeground" = "#0000";
        "editorOverviewRuler.border" = "#0000";
        "sideBar.border" = "#0000";
        "editorGroup.border" = "#0000";
      };
    };
  };

  specialisation.catppuccin.configuration = {
    programs.vscode.profiles.default = {
      extensions = with inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
        catppuccin.catppuccin-vsc
      ];

      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
      };
    };
  };
}
