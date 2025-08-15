{pkgs, ...}: {
  imports = [
    ./config.nix
    ./programs
  ];

  programs.rofi = {
    enable = true;

    # Specify rofi-wayland because wayland
    package = pkgs.rofi-wayland;
  };
}
