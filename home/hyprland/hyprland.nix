{...}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [",preferred,auto,1"];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "waybar"
        "swww-daemon"
        "nm-applet"

        # Start apps
        "todoist-electron"
        "obsidian"
        "anki"
        "spotify"
        "firefox"
        "code"

        # Start clipboard manager
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      input = {
        kb_layout = "us";
        repeat_delay = 300;
        repeat_rate = 50;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      gestures.workspace_swipe = false;

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        resize_on_border = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        rounding_power = 2;
        active_opacity = 0.8;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1;
        dim_inactive = false;
        dim_strength = 0.05;
        shadow = {
          enabled = true;
          range = 5;
          render_power = 2;
          ignore_window = true;
        };
        blur = {
          enabled = true;
          size = 10;
          passes = 4;
          ignore_opacity = "on";
          popups = true;
          new_optimizations = true;
        };
      };

      windowrule = [
        "opacity 1.0 override, class:^(firefox|thunar)$"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      animations = {
        enabled = true;
        animation = "workspaces, 1, 8, default, slidefade 50%";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

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
        "$mainMod, A, exec, ~/bin/wifi.sh"
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

      windowrulev2 = [
        "workspace 5 silent,class:^(spotify)$"
        "workspace 6 silent,class:^(Todoist)$"
        "workspace 9 silent,class:^(Anki)$"
        "workspace 10 silent,class:^(obsidian)$"
        "float, class:^(spotify)$"
        "move 81 146, class:^(spotify)$"
        "size 1068 670, class:^(spotify)$"
        "float, class:^(org.gnome.Calculator)$"
        "float, title:^(Picture-in-Picture)$"
        "move 1492 839, title:^(Picture-in-Picture)$"
        "size 427 240, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "float, title:^(Bluetooth Devices)$"
        "pin, title:^(Bluetooth Devices)$"
        "size 500 300, title:^(Bluetooth Devices)$"
      ];
    };
  };
}
