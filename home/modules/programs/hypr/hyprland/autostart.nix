{...}: {
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "${./scripts/autostart.sh}"
    ];
  };
}
