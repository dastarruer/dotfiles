{inputs, ...}: {
  flake.nixosModules.desktop_vscode = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.dastarruer = let
      profile = config.custom.desktop.vscode.profile;
      theme = config.custom.theme.name;
      vscode-extensions = inputs.vscode-extensions.extensions.${pkgs.stdenv.system}.vscode-marketplace;
    in {
      stylix.targets.vscode.enable = false;

      programs.vscode.profiles.${profile} = {
        # Extensions required for theming
        extensions = with vscode-extensions; [
          pkief.material-icon-theme
          tintedtheming.base16-tinted-themes
        ];

        userSettings = {
          # Theme
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.colorTheme" = "base16-${theme}";

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
    };
  };
}
