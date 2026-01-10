{
  pkgs,
  vscode-extensions,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  # Globally installed extensions
  programs.vscode.profiles.${profile} = {
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
