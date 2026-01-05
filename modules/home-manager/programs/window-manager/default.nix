{lib, ...}: {
  imports = [
    ./rofi
    ./dunst
    ./waybar
    ./hypr
    ./swww.nix
    ./batsignal.nix
  ];

  options = {
    dotfiles.window-manager.enable = lib.mkEnableOption "Enable a window-manager instead of a desktop environment.";
  };
}
