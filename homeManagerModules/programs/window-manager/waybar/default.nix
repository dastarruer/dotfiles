{
  config,
  lib,
  ...
}: {
  imports = [
    ./theme.nix
    ./config.nix
  ];

  options = {
    dotfiles.window-manager.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable waybar, a status bar.";
    };
  };

  config = lib.mkIf config.dotfiles.window-manager.waybar.enable {
    programs.waybar.enable = true;

    wayland.windowManager.hyprland.settings = {
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
        "blur, waybar"
        "xray 0, waybar"
        "ignorezero, waybar"
      ];
    };
  };
}
