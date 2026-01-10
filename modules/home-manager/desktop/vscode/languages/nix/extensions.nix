{
  vscode-extensions,
  pkgs,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.extensions = with vscode-extensions; [
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
