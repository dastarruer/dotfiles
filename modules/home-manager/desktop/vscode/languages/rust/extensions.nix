{
  vscode-extensions,
  pkgs,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.extensions = [
    vscode-extensions.rust-lang.rust-analyzer
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    vscode-extensions.tamasfe.even-better-toml
    pkgs.vscode-extensions.fill-labs.dependi
  ];
}
