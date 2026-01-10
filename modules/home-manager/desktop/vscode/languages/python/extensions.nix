{
  vscode-extensions,
  pkgs,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
  in {
  programs.vscode.profiles.${profile}.extensions = with vscode-extensions; [
    ms-python.python # Python LSP
    ms-python.vscode-pylance

    # There was also black but ruff can sort imports too so I went with this
    charliermarsh.ruff # Python formatter
  ];

  home.packages = with pkgs; [
    python312
    python312Packages.python-lsp-server # Needed for python lsp?
  ];
}
