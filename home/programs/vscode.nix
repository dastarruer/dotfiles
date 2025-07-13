{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Language support
        jnoortheen.nix-ide
        rust-lang.rust-analyzer

        # Formatters
        kamadorueda.alejandra
        esbenp.prettier-vscode
        foxundermoon.shell-format

        # Other
        aaron-bond.better-comments
        usernamehw.errorlens
      ];

      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.wordWrap" = "bounded";
        "editor.autoClosingQuotes" = "always";
        "editor.autoClosingBrackets" = "always";
        "workbench.sideBar.location" = "right";
        "explorer.confirmDelete" = false;

        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
      };
    };
  };
}
