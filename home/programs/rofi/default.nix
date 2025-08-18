{pkgs, ...}: {
  imports = [
    ./config.nix
    ./plugins
  ];

  programs.rofi = {
    enable = true;

    # Specify rofi-wayland because wayland
    package = pkgs.rofi-wayland;
  };
}
