{
  pkgs,
  inputs,
  ...
}: {
  # Vscode extensions that I want globally
  programs.vscode.profiles.default.extensions = with inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
    aaron-bond.better-comments
    usernamehw.errorlens
  ];
}
