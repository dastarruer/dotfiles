{lib, ...}: {
  imports = [
    ./rofi
    ./dunst
    ./waybar
    ./hypr
    ./swww.nix
    ./batsignal.nix
    ./sherlock.nix
  ];

  options = {
    home-manager.window-manager.enable = lib.mkEnableOption "Enable a window-manager instead of a desktop environment.";
  };
}
