{config, ...}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.userSettings = {
    "[python]" = {
      editor.defaultFormatter = "charliermarsh.ruff";
      editor.formatOnSave = true;

      # Organize imports using ruff
      editor.codeActionsOnSave = {
        source.organizeImports.ruff = "explicit";
      };

      # Enable ruff linting/formatting
      ruff.lint.enable = true;
      ruff.format.enable = true;

      # Enable autoimports
      python.analysis.autoImportCompletions = true;

      # Use strict type-checking
      python.analysis.typeCheckingMode = "strict";

      python.languageServer = "Pylance";
    };

    emmet.includeLanguages = {
      "django-html" = "html";
    };

    # Configure djlint to be the default for teh following
    "[html][django-html][handlebars][hbs][mustache][jinja][jinja-html][nj][njk][nunjucks][twig]" = {
      editor.defaultFormatter = "monosans.djlint";
    };
  };
}
