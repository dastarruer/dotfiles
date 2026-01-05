{...}: {
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      "opacity 1.0 override, class:^(firefox|thunar|firefox-nightly)$"
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "noshadow, floating:0"
    ];

    windowrulev2 = [
      "workspace 6 silent,class:^(Todoist)$"
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
    ];
  };
}
