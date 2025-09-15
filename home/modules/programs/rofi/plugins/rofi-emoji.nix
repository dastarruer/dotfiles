{pkgs, ...}: {
  programs.rofi.plugins = [
    pkgs.rofi-emoji
  ];
}
