{config, ...}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.userSettings = {
    "[rust]" = {
      editor.defaultFormatter = "rust-lang.rust-analyzer";
    };

    # Use clippy to check for errors
    "rust-analyzer.check.command" = "clippy";

    # Use Self::fn() instead of Type::fn()
    "rust-analyzer.assist.preferSelf" = false;

    # Enable all features for rustfmt
    "rust-analyzer.cargo.allFeatures" = true;

    "rust-analyzer.server.path" = "rust-analyzer";
  };
}
