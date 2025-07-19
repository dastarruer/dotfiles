{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
    "swww-daemon"
    "nm-applet"

    # Start apps
    "todoist-electron"
    "obsidian"
    "anki"
    "spotify"
    "firefox"
    "codium"

    # Start clipboard manager
    "wl-paste --type text --watch cliphist store"
    "wl-paste --type image --watch cliphist store"

    # Auto-suspend after 10 min of idle
    "swayidle -w timeout 600 \"playerctl -a pause && hyprlock & disown && systemctl suspend\" &"
  ];
}
