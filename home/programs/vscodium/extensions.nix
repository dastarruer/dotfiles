{
  pkgs,
  inputs,
  ...
}: {
  # Define vscode extensions
  programs.vscode.profiles.default.extensions = with inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
    # Formatters
    kamadorueda.alejandra
    esbenp.prettier-vscode
    foxundermoon.shell-format

    # Appearance
    pkief.material-icon-theme
    jdinhlife.gruvbox

    # Other
    aaron-bond.better-comments
    usernamehw.errorlens
  ];

  # Add necessary packages for each extension
  home.packages = with pkgs; [
    rustfmt
  ];
}
