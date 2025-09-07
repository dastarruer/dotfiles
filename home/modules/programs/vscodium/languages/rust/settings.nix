{...}: {
  programs.vscode.profiles.default.userSettings = {
    "[rust]" = {
      editor.defaultFormatter = "rust-lang.rust-analyzer";
    };

    # Use clippy to check for errors
    "rust-analyzer.check.command" = "clippy";
  };
}
