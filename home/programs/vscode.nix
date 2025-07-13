{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # LSPs
        jnoortheen.nix-ide
        rust-lang.rust-analyzer

        # Formatters
        kamadorueda.alejandra
        esbenp.prettier-vscode
        foxundermoon.shell-format

        # Appearance
        pkief.material-icon-theme
        jdinhlife.gruvbox

        # Other
        aaron-bond.better-comments
        usernamehw.errorlens
      ];

      userSettings = {
        # File explorer settings
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;

        # Terminal settings
        "terminal.integrated.enableMultiLinePasteWarning" = false;

        # Git
        "git.openRepositoryInParentFolders" = "always";

        # UI
        "workbench.sideBar.location" = "right";
        "workbench.activityBar.location" = "top";
        "workbench.statusBar.visible" = false;
        "editor.minimap.enabled" = false;

        # Appearance
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Gruvbox Dark Medium";

        # Global formatting settings
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;

        # Nix specific settings
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nixpkgs" = {
          "expr" = "import <nixpkgs { }";
        };
        "formatting" = {
          "command" = ["alejandra"];
        };

        # Language-specific formatter settings
        "[javascript]" = {
          editor.defaultFormatter = "esbenp.prettier-vscode";
        };
        "[css]" = {
          editor.defaultFormatter = "esbenp.prettier-vscode";
        };
        "[html]" = {
          editor.defaultFormatter = "esbenp.prettier-vscode";
        };
        "[json]" = {
          editor.defaultFormatter = "esbenp.prettier-vscode";
        };
        "[go]" = {
          editor.defaultFormatter = "golang.go";
        };
        "[rust]" = {
          editor.defaultFormatter = "rust-lang.rust-analyzer";
        };
        "[shellscript]" = {
          editor.defaultFormatter = "foxundermoon.shell-format";
        };
        "[ignore]" = {
          editor.defaultFormatter = "foxundermoon.shell-format";
        };
        "[nix]" = {
          editor.defaultFormatter = "kamadorueda.alejandra";
        };

        # Other
        "files.autoSave" = "afterDelay";
        "editor.wordWrap" = "bounded";
        "editor.autoClosingQuotes" = "always";
        "editor.autoClosingBrackets" = "always";
      };
    };
  };
}
