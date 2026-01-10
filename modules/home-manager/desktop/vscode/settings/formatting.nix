{config, ...}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  # Global formatting settings
  programs.vscode.profiles.${profile}.userSettings = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnPaste" = true;
    "editor.formatOnSave" = true;
    "editor.formatOnType" = true;
  };
}
