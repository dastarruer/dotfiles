{
  vscode-extensions,
  pkgs,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.extensions = with vscode-extensions; [
    ms-azuretools.vscode-containers
    # ms-vscode-remote.remote-containers
  ];

  home.packages = with pkgs; [
    # obviously i gotta install docker...
    docker-compose
    # devcontainer # isolated dev environments
  ];
}
