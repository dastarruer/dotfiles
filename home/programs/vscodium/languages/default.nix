{...}: {
  # Import language specific options
  imports = [
    ./nix
  ];

  programs.vscode.profiles.default.userSettings = {
    # Language-specific formatter settings
    "[javascript]" = {
      editor.defaultFormatter = "esbenp.prettier-vscode";
    };
    "[css]" = {
      editor.defaultFormatter = "esbenp.prettier-vscode";
    };
    "[html]" = {
      editor.defaultFormatter = "esbenp.prettier-vscode";
    };
    "[json]" = {
      editor.defaultFormatter = "esbenp.prettier-vscode";
    };
    "[go]" = {
      editor.defaultFormatter = "golang.go";
    };
    "[rust]" = {
      editor.defaultFormatter = "rust-lang.rust-analyzer";
    };
    "[shellscript]" = {
      editor.defaultFormatter = "foxundermoon.shell-format";
    };
    "[ignore]" = {
      editor.defaultFormatter = "foxundermoon.shell-format";
    };
  };
}
