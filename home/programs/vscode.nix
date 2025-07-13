{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Language support
        jnoortheen.nix-ide
        rust-lang.rust-analyzer

        # Formatters
        kamadorueda.alejandra
        esbenp.prettier-vscode
        foxundermoon.shell-format

        # Other
        aaron-bond.better-comments
        usernamehw.errorlens
      ];
    };
  };
}
