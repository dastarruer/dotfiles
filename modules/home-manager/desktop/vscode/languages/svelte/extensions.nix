{
  vscode-extensions,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.extensions = [
    vscode-extensions.svelte.svelte-vscode
  ];
}
