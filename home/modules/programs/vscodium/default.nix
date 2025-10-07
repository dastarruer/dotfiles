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

  # Run vscodium under wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
