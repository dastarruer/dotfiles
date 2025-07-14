{pkgs, ...}: {
  imports = [
    ./extensions.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      userSettings = {
      };
    };
  };
}
