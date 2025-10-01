{
  vscode-extensions,
  pkgs,
  ...
}: {
  programs.vscode.profiles.default.extensions = with vscode-extensions; [
    # nix lsp
    jnoortheen.nix-ide

    # Formatter
    kamadorueda.alejandra
  ];

  home.packages = with pkgs; [
    # Required for lsp support
    nixd
    alejandra
  ];
}
