{...}: {
  wayland.windowManager.hyprland.settings = {
    input = {
      # Keyboard layouts
      "kb_layout" = "us, es";
      "kb_options" = "grp:alt_space_toggle";

      # Keyboard settings
      "repeat_delay" = "300";
      "repeat_rate" = "50";

      # Mouse settings
      "follow_mouse" = "1";
      "sensitivity" = "0";

      # Touchpad settings
      touchpad = {
        natural_scroll = 1;
        disable_while_typing = 0;
      };
    };

    # Device-specific settings
    device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    };
  };
}
