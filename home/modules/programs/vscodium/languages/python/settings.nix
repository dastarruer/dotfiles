{...}: {
  programs.vscode.profiles.default.userSettings = {
    "[python]" = {
      editor.defaultFormatter = "charliermarsh.ruff";
      editor.formatOnSave = true;

      # Organize imports using ruff
      editor.codeActionsOnSave = {
        source.organizeImports.ruff = "explicit";
      };

      ruff.lint.enable = true;
      ruff.format.enable = true;
    };
  };
}
