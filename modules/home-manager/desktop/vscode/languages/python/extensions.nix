{
  vscode-extensions,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.extensions = with vscode-extensions; [
    ms-python.python # Python LSP
    ms-python.vscode-pylance
    batisteo.vscode-django
    monosans.djlint # Django-html template linter
    charliermarsh.ruff # There was also black but ruff can sort imports too so I went with this
  ];
}
