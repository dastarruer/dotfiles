{...}: {
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      "opacity 1.0 override, class:^(firefox|thunar|firefox-nightly)$"
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "noshadow, floating:0"
      "noanim, title:^(flameshot)$"
      "float, title:^(flameshot)$"
      "move 0 0, title:^(flameshot)$"
      "pin, title:^(flameshot)$"
      "noinitialfocus, title:^(flameshot)$"
      "monitor 1, class:^(flameshot)$"
      "float, title:^(Picture-in-Picture)$"
      "move 1492 839, title:^(Picture-in-Picture)$"
      "size 427 240, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "float, class:^(spotify)$"
      "move 81 146, class:^(spotify)$"
      "size 1068 670, class:^(spotify)$"
    ];

    windowrulev2 = [
      "workspace 5 silent,class:^(spotify)$"
      "workspace 6 silent,class:^(Todoist)$"
      "workspace 9 silent,class:^(anki)$"
      "workspace 10 silent,class:^(obsidian)$"
      "workspace 4 silent,title:^(WhatsApp)$"
      "float, title:^(Bluetooth Devices)$"
      "pin, title:^(Bluetooth Devices)$"
      "size 500 300, title:^(Bluetooth Devices)$"
      "float, class:^(org.pulseaudio.pavucontrol)$"
      "pin, class:^(org.pulseaudio.pavucontrol)$"
      "size 750 400, class:^(org.pulseaudio.pavucontrol)$"
      "pin, title:^(Wi-Fi Network Authentication Required)$"
      "idleinhibit fullscreen, class:^(*)$"
      "idleinhibit fullscreen, title:^(*)$"
      "idleinhibit fullscreen, fullscreen:1"
      "idleinhibit focus, class:^(org.pwmt.zathura)$"
      "idleinhibit focus, class:^(anki)$"
    ];
  };
}
