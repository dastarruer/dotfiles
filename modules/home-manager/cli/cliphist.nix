{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
  rofi = config.home-manager.window-manager.rofi;
  cfg = config.home-manager.cliphist;
in {
  options = {
    home-manager.cliphist.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable cliphist, a clipboard history manager.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cliphist
    ];

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      # Start clipboard manager on startup
      "exec-once" = [
        "wl-paste --type text --watch cliphist store &"
        "wl-paste --type image --watch cliphist store &"
      ];

      # If rofi is enabled
      bind = lib.mkIf rofi.enable [
        "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ];
    };
  };
}
