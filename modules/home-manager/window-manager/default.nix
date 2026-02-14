{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./rofi
    ./dunst
    ./waybar
    ./swww.nix
    ./batsignal.nix
    ./sherlock.nix
    ./hyprland
    ./hypridle.nix
    ./hyprlock
    ./hyprsunset.nix
  ];

  options = {
    home-manager.window-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = osConfig.programs.hyprland.enable;
      description = "Enable a window manager.";
    };
  };
}
