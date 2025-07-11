{...}: {
  wayland.windowManager.hyprland.settings = {
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

    device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    };

    gestures.workspace_swipe = false;
  };
}
