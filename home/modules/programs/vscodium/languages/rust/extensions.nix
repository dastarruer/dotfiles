{pkgs, ...}: {
  # TODO: Use vscode extensions flake here instead
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    # Rust lsp
    rust-lang.rust-analyzer

    # Rust debugger
    vadimcn.vscode-lldb

    # Cargo.toml support
    tamasfe.even-better-toml

    # Checks dependency versions to make sure they are up to date
    fill-labs.dependi
  ];
}
