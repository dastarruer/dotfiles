{
  pkgs,
  vscode-extensions,
  ...
}: {
  # Globally installed extensions
  programs.vscode.profiles.default = {
    extensions = [
      vscode-extensions.aaron-bond.better-comments
      pkgs.vscode-extensions.usernamehw.errorlens

      # Necessary to have both
      pkgs.vscode-extensions.github.copilot
      pkgs.vscode-extensions.github.copilot-chat
    ];

    userSettings = {
      "errorLens.toggle" = true;
    };
  };
}
