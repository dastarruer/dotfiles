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
  programs.vscode.profiles.${profile}.extensions = with vscode-extensions; [
    ms-python.python # Python LSP
    # Without resetting the license, pylance just refuses to build. Doesn't matter if it's in allowUnfreePredicate, it just won't build.
    (resetLicense ms-python.vscode-pylance)
    batisteo.vscode-django
    monosans.djlint # Django-html template linter
    charliermarsh.ruff # There was also black but ruff can sort imports too so I went with this
  ];
}
