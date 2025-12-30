{vscode-extensions, ...}: {
  # Import language specific options
  imports = [
    ./nix
    ./rust
    ./docker
    ./python
  ];

  # General language formatter settings
  programs.vscode.profiles.default = {
    extensions = with vscode-extensions; [
      esbenp.prettier-vscode
      # foxundermoon.shell-format
    ];
    userSettings = {
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
      # "[shellscript]" = {
      #   editor.defaultFormatter = "foxundermoon.shell-format";
      # };
      "[ignore]" = {
        editor.defaultFormatter = "foxundermoon.shell-format";
      };
    };
  };
}
