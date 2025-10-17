{...}: {
  programs.vscode.profiles.default.userSettings = {
    "[rust]" = {
      editor.defaultFormatter = "rust-lang.rust-analyzer";
    };

    # Use clippy to check for errors
    "rust-analyzer.check.command" = "clippy";

    # Use Self::fn() instead of Type::fn()
    "rust-analyzer.assist.preferSelf" = false;

    # Enable all features for rustfmt
    "rust-analyzer.cargo.allFeatures" = true;
  };
}
