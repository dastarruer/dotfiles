{
  vscode-extensions,
  pkgs,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile} = {
    extensions = [
      vscode-extensions.rust-lang.rust-analyzer
      pkgs.vscode-extensions.vadimcn.vscode-lldb
      vscode-extensions.tamasfe.even-better-toml
      pkgs.vscode-extensions.fill-labs.dependi
    ];
    userSettings = {
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
  };
}
