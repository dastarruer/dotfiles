{...}: {
  imports = [
    ./theme.nix
    ./config.nix
  ];

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
}
