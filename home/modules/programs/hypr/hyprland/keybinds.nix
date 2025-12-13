{...}: {
  wayland.windowManager.hyprland.settings = {
    # General Mod and Terminal
    "bind" = [
      "SUPER, RETURN, exec, kitty"
      "SUPER, Q, killactive"
      "SUPER, E, exec, $fileManager"
      "SUPER, Space, togglefloating"
      "SUPER, H, movefocus, l"
      "SUPER, L, movefocus, r"
      "SUPER, J, movefocus, u"
      "SUPER, K, movefocus, d"
      "SUPER+SHIFT, H, movewindow, l"
      "SUPER+SHIFT, L, movewindow, r"
      "SUPER+SHIFT, K, movewindow, u"
      "SUPER+SHIFT, J, movewindow, d"
      "SUPER+CONTROL, H, resizeactive, -50 0"
      "SUPER+CONTROL, L, resizeactive, 50 0"
      "SUPER+CONTROL, K, resizeactive, 0 -50"
      "SUPER+CONTROL, J, resizeactive, 0 50"
      "SUPER+ALT, H, moveactive, -50 0"
      "SUPER+ALT, L, moveactive, 50 0"
      "SUPER+ALT, K, moveactive, 0 -50"
      "SUPER+ALT, J, moveactive, 0 50"
      "SUPER+SHIFT+ALT, H, moveactive, -10 0"
      "SUPER+SHIFT+ALT, L, moveactive, 10 0"
      "SUPER+SHIFT+ALT, K, moveactive, 0 -10"
      "SUPER+SHIFT+ALT, J, moveactive, 0 10"

      # Workspace switching
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      "SUPER, minus, workspace, 11"

      # Move windows to workspace
      "SUPER+SHIFT, 1, movetoworkspacesilent, 1"
      "SUPER+SHIFT, 2, movetoworkspacesilent, 2"
      "SUPER+SHIFT, 3, movetoworkspacesilent, 3"
      "SUPER+SHIFT, 4, movetoworkspacesilent, 4"
      "SUPER+SHIFT, 5, movetoworkspacesilent, 5"
      "SUPER+SHIFT, 6, movetoworkspacesilent, 6"
      "SUPER+SHIFT, 7, movetoworkspacesilent, 7"
      "SUPER+SHIFT, 8, movetoworkspacesilent, 8"
      "SUPER+SHIFT, 9, movetoworkspacesilent, 9"
      "SUPER+SHIFT, 0, movetoworkspacesilent, 10"
      "SUPER+SHIFT, minus, movetoworkspacesilent, 11"

      # Other keybinds
      "SUPER, P, exec, ~/.dotfiles/config/hypr/hyprland/scripts/kill_apps.sh"
      "SUPER, O, exec, ~/.dotfiles/config/hypr/hyprland/scripts/apps.sh"
      "SUPER, TAB, workspace, previous"
      "SUPER+SHIFT, W, exec, ~/bin/change-wallpaper.sh"
      "SUPER, K, exec, ~/.dotfiles/config/hypr/hyprland/scripts/move_windows_to_monitor.sh"
      "SUPER, Y, exec, ~/.dotfiles/config/hypr/hyprland/scripts/toggle_monitor.sh"
      "SUPER+SHIFT, Y, exec, ~/.dotfiles/config/hypr/hyprland/scripts/toggle_laptop_screen.sh"
      "SUPER, T, exec, ~/bin/switch_theme.sh"
      "SUPER, B, exec, ~/bin/airpods.sh"
      "SUPER, E, exec, ~/bin/power.sh"
      "SUPER, W, exec, pidof waybar && pkill waybar || waybar &"
      ",Print, exec, ~/bin/screenshot.sh"
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER+SHIFT, S, movetoworkspace, special:magic"
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"
      "SUPER, G, centerwindow"
      "SUPER, F, fullscreen"
      ",XF86AudioPlay, exec, playerctl play-pause -p spotify"
      "SHIFT,XF86AudioPlay, exec, $HOME/bin/pause-all.sh"
      ",XF86AudioPrev, exec, playerctl previous"
      ",XF86AudioNext, exec, playerctl next"

      # Rofi
      "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "SUPER, D, exec, rofi -show drun"
      "SUPER, C, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}'\" | wl-copy && notify-send -t 1000 \"Copied to clipboard\""
      "SUPER, A, exec, rofi -modi emoji -show emoji"
    ];

    # Mouse bindings
    "bindm" = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    # Extended keys
    "bindel" = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "ALT, B, exec, ~/.dotfiles/config/hypr/hyprland/scripts/brightness.sh + 5"
      "ALT, V, exec, ~/.dotfiles/config/hypr/hyprland/scripts/brightness.sh - 5"
    ];

    # Legacy media keys
    "bindl" = [
      ",XF86AudioMedia, exec, playerctl play-pause"
      ",XF86AudioStop, exec, playerctl stop"
    ];

    # Brightness keys
    "bindle" = [
      ",XF86MonBrightnessUp, exec, brillo --brightness=raise 5"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness=lower 5"
    ];
  };
}
