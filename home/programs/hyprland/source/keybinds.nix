{...}: {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$menu" = "rofi -show drun";

    bind = [
      "$mainMod, RETURN, exec, $terminal"
      "$mainMod, Q, killactive"
      "$mainMod, M, exit"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, Space, togglefloating"
      "$mainMod, D, exec, $menu"
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, J, movefocus, u"
      "$mainMod, K, movefocus, d"
      "$mainMod SHIFT, H, movewindow, l"
      "$mainMod SHIFT, L, movewindow, r"
      "$mainMod SHIFT, K, movewindow, u"
      "$mainMod SHIFT, J, movewindow, d"
      "$mainMod CONTROL, H, resizeactive, -50 0"
      "$mainMod CONTROL, L, resizeactive, 50 0"
      "$mainMod CONTROL, K, resizeactive, 0 -50"
      "$mainMod CONTROL, J, resizeactive, 0 50"
      "$mainMod ALT, H, moveactive, -50 0"
      "$mainMod ALT, L, moveactive, 50 0"
      "$mainMod ALT, K, moveactive, 0 -50"
      "$mainMod ALT, J, moveactive, 0 50"
      "$mainMod SHIFT ALT, H, moveactive, -10 0"
      "$mainMod SHIFT ALT, L, moveactive, 10 0"
      "$mainMod SHIFT ALT, K, moveactive, 0 -10"
      "$mainMod SHIFT ALT, J, moveactive, 0 10"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod, minus, workspace, 11"
      "$mainMod, equal, workspace, 12"
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod SHIFT, minus, movetoworkspace, 11"
      "$mainMod SHIFT, equal, movetoworkspace, 12"
      "SUPER,TAB,workspace,previous"
      "$mainMod SHIFT, W, exec, ~/bin/change_wallpaper.sh"
      "$mainMod, T, exec, ~/bin/switch_theme.sh"
      "$mainMod, B, exec, ~/bin/airpods.sh"
      "$mainMod, E, exec, ~/bin/power.sh"
      # "$mainMod, A, exec, ~/bin/wifi.sh"
      "$mainMod, W, exec, pkill waybar && waybar &"
      "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ", Print, exec, ~/bin/screenshot.sh"
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
      "$mainMod, Y, pin"
      "$mainMod, G, centerwindow"
      "$mainMod, F, fullscreen"
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPrev,exec,playerctl previous"
      ",XF86AudioNext,exec,playerctl next"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "ALT, B , exec, brillo -A 5 -q"
      "ALT , V, exec, brillo -U 5 -q"
    ];

    bindl = [
      ",XF86AudioMedia,exec,playerctl play-pause"
      ",XF86AudioStop,exec,playerctl stop"
    ];

    bindle = [
      ",XF86MonBrightnessUp,exec,brillo --brightness=raise 5"
      ",XF86MonBrightnessDown,exec,swayosd-client --brightness=lower 5"
    ];
  };
}
