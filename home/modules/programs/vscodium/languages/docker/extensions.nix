{
  vscode-extensions,
  pkgs,
  ...
}: {
  programs.vscode.profiles.default.extensions = with vscode-extensions; [
    ms-azuretools.vscode-docker
  ];

  # obviously i gotta install docker...
  home.packages = with pkgs; [
    docker-compose
  ];
}
