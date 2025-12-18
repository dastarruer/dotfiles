{...}: {
  wayland.windowManager.hyprland.settings = {
    "bind" = [
      "SUPER, Q, killactive"
      "SUPER, Space, togglefloating"
      "SUPER, G, centerwindow"
      "SUPER, F, fullscreen"
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
    ];
  };
}
