{
  vscode-extensions,
  pkgs,
  ...
}: {
  # Install nix lsp
  programs.vscode.profiles.default.extensions = with vscode-extensions; [
    jnoortheen.nix-ide
  ];

  # Required for lsp support
  home.packages = with pkgs; [
    nixd
  ];
}
