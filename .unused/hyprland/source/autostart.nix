{config, ...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
    "swww-daemon"
    "nm-applet"
    "hypridle"

    # Start apps
    "todoist-electron"
    "anki"
    "spotify"
    "firefox"
    "codium"
    "flatpak run md.obsidian.Obsidian"

    # Start clipboard manager
    "wl-paste --type text --watch cliphist store"
    "wl-paste --type image --watch cliphist store"

    # Start smart-pause-resume script
    "${config.home.homeDirectory}/bin/smart-pause-resume.sh"
  ];
}
