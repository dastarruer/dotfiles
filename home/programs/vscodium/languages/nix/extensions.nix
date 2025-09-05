{
  inputs,
  pkgs,
  ...
}: {
  # Install nix lsp
  programs.vscode.profiles.default.extensions = with inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
    jnoortheen.nix-ide
  ];

  # Required for lsp support
  home.packages = with pkgs; [
    nixd
  ];
}
