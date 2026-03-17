{
  vscode-extensions,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
  resetLicense = drv:
    drv.overrideAttrs (prev: {
      meta =
        prev.meta
        // {
          license = [];
        };
    });
in {
  programs.vscode.profiles.${profile} = {
    extensions = with vscode-extensions; [
      ms-python.python # Python LSP
      # Without resetting the license, pylance just refuses to build. Doesn't matter if it's in allowUnfreePredicate, it just won't build.
      (resetLicense ms-python.vscode-pylance)
      batisteo.vscode-django
      monosans.djlint # Django-html template linter
      charliermarsh.ruff # There was also black but ruff can sort imports too so I went with this
    ];

    userSettings = {
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
  };
}
