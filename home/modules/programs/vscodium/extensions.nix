{
  pkgs,
  inputs,
  ...
}: {
  # Vscode extensions that I want globally
  # To get the name of an extension, search it up in vscode, and copy the identifier
  programs.vscode.profiles.default.extensions = with inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
    aaron-bond.better-comments
    usernamehw.errorlens
  ];
}
