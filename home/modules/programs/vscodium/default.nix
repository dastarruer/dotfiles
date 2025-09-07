{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings
    ./languages
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
