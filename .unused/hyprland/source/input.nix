{...}: {
  wayland.windowManager.hyprland.settings = {
    input = {
      # Keyboard layouts
      kb_layout = "us, es";
      kb_options = "grp:alt_space_toggle";

      repeat_delay = 300;
      repeat_rate = 50;
      follow_mouse = 1;
      sensitivity = 0;
      touchpad = {
        natural_scroll = true;
      };
    };

    device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    };

    gestures.workspace_swipe = false;
  };
}
