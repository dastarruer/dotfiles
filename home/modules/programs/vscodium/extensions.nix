{
  pkgs,
  vscode-extensions,
  ...
}: {
  # Vscode extensions that I want globally
  programs.vscode.profiles.default = {
    extensions = [
      vscode-extensions.aaron-bond.better-comments
      pkgs.vscode-extensions.usernamehw.errorlens
    ];

    userSettings = {
      "errorLens.toggle" = true;
    };
  };
}
