{config, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      # ... your other Hyprland settings (monitors, animations, etc.)

      # --- Ax-Shell Integration ---
      # Use the '++' operator to merge Ax-Shell's binds with your own.
      bind =
        config.programs.ax-shell.hyprlandBinds
        ++ [
          # Add your custom keybinds here
          "SUPER, return, exec, kitty"
          "SUPER, Q, killactive,"
        ];

      # Merge Ax-Shell's startup commands with your own.
      exec-once =
        config.programs.ax-shell.hyprlandExecOnce
        ++ [
          "swww-daemon"
          "nm-applet"
          "hypridle"

          "todoist-electron"
          "anki"
          "spotify"
          "flatpak run md.obsidian.Obsidian"

          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];
    };
  };
}
