{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "opacity 1.0 override, class:^(firefox|thunar)$"
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
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
}
