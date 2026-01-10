{config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in{
  # Define other settings here
  programs.vscode.profiles.${profile}.userSettings = {
    # File explorer settings
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "explorer.confirmPasteNative" = false;

    # Terminal settings
    "terminal.integrated.enableMultiLinePasteWarning" = "never";

    # Git
    "git.openRepositoryInParentFolders" = "always";

    # Other
    "files.autoSave" = "afterDelay";
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;
    "editor.wordWrap" = "bounded";
    "editor.autoClosingQuotes" = "always";
    "editor.autoClosingBrackets" = "always";
    "editor.tabSize" = 4;
    "editor.detectIndentation" = false;
    "editor.tabCompletion" = "on";
    "update.mode" = "none";
    "extensions.ignoreRecommendations" = true;
  };
}
