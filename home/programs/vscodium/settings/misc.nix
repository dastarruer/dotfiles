{...}: {
  # Define other settings here
  programs.vscode.profiles.default.userSettings = {
    # File explorer settings
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "explorer.confirmPasteNative" = false;

    # Terminal settings
    "terminal.integrated.enableMultiLinePasteWarning" = false;

    # Git
    "git.openRepositoryInParentFolders" = "always";

    # Other
    "files.autoSave" = "afterDelay";
    "editor.wordWrap" = "bounded";
    "editor.autoClosingQuotes" = "always";
    "editor.autoClosingBrackets" = "always";
  };
}
