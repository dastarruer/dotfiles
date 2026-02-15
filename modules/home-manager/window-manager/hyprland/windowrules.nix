{...}: {
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      "opacity 1.0 override, match:class firefox|thunar|firefox-nightly"
      "suppress_event maximize, match:class .*"
      "no_initial_focus on,match:class ^$,match:title ^$,match:xwayland 1,match:float 1,match:fullscreen 0,match:pin 0"

      # No shadows on non-floating windows
      "no_shadow on, match:float 0"

      "workspace 6 silent,match:class Todoist"
      "workspace 4 silent,match:title WhatsApp"
      "float on, match:title Bluetooth Devices"
      "pin on, match:title Bluetooth Devices"
      "size 500 300, match:title Bluetooth Devices"
      "float on, match:class org.pulseaudio.pavucontrol"
      "pin on, match:class org.pulseaudio.pavucontrol"
      "size 750 400, match:class org.pulseaudio.pavucontrol"
      "pin on, match:title Wi-Fi Network Authentication Required"
      "idle_inhibit fullscreen, match:class *"
      "idle_inhibit fullscreen, match:title *"
      "idle_inhibit fullscreen, match:fullscreen 1"
    ];
  };
}
