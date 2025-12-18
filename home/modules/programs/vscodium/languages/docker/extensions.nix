{
  vscode-extensions,
  pkgs,
  ...
}: {
  programs.vscode.profiles.default.extensions = with vscode-extensions; [
    ms-azuretools.vscode-containers
    # ms-vscode-remote.remote-containers
  ];

  home.packages = with pkgs; [
    # obviously i gotta install docker...
    docker-compose
    # devcontainer # isolated dev environments
  ];
}
