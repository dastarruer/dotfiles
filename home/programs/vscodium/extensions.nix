{pkgs, ...}: {
  # Define vscode extensions
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    # LSPs
    jnoortheen.nix-ide
    rust-lang.rust-analyzer

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
    nixd
    alejandra
    rustfmt
  ];
}
