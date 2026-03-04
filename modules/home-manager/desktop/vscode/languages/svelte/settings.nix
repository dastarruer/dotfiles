{config, ...}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.userSettings = {
    # Enable typescript support
    "svelte.enable-ts-plugin" = true;
  };
}
