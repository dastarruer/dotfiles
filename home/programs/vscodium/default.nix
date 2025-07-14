{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
