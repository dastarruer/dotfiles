{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.dotfiles.window-manager.hypr.hyprland;
  rofi = config.dotfiles.window-manager.rofi;
  cfg = config.dotfiles.cliphist;
in {
  options = {
    dotfiles.cliphist.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
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
