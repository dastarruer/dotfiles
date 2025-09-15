{
  vscode-extensions,
  pkgs,
  ...
}: {
  programs.vscode.profiles.default.extensions = [
    vscode-extensions.rust-lang.rust-analyzer
    vscode-extensions.vadimcn.vscode-lldb
    vscode-extensions.tamasfe.even-better-toml
    pkgs.vscode-extensions.fill-labs.dependi
  ];
}
