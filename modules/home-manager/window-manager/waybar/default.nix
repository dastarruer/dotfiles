{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  imports = [
    ./theme.nix
    ./config.nix
  ];

  options = {
    home-manager.window-manager.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable waybar, a status bar.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.waybar.enable {
    programs.waybar.enable = true;

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      # Start waybar
      "exec-once" = [
        "waybar &"
      ];
      # Start/stop waybar keybind
      bind = [
        "SUPER, W, exec, pidof waybar && pkill waybar || waybar &"
      ];
      # more hyprland stuff i dont understand
      layerrule = [
        "blur on, match:namespace waybar"
        "xray on, match:namespace waybar"
      ];
    };
  };
}
