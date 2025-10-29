{vscode-extensions, ...}: {
  programs.vscode.profiles.default.extensions = with vscode-extensions; [
    ms-python.python # Python LSP
  ];
}
