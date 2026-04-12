{inputs, ...}: {
  flake.nixosModules.desktop_vscode = {config, ...}: {
    home-manager.users.dastarruer = let
      profile = config.custom.desktop.vscode.profile;
    in {
      # Global formatting settings
      programs.vscode.profiles.${profile}.userSettings = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
      };
    };
  };
}
