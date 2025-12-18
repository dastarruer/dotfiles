{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    cliphist
  ];

  wayland.windowManager.hyprland.settings = {
    # Start clipboard manager on startup
    "exec-once" = [
      "wl-paste --type text --watch cliphist store &"
      "wl-paste --type image --watch cliphist store &"
    ];

    # If rofi is enabled
    bind = lib.mkIf config.programs.rofi.enable [
      "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
    ];
  };
}
