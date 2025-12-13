{...}: {
  imports = [
    ./theme.nix
    ./config.nix
  ];

  programs.waybar.enable = true;

  # Start waybar
  wayland.windowManager.hyprland.settings."exec-once" = [
    "waybar &"
  ];
}
