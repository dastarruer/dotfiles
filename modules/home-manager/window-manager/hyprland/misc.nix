{...}: {
  wayland.windowManager.hyprland.settings = {
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      middle_click_paste = false;

      allow_session_lock_restore = true; # Allows to restart lockscreen if it crashes
    };

    binds = {
      # If I have a pinned picture-in-picture window, it will stay pinned even after fullscreening it
      allow_pin_fullscreen = true;
    };

    ecosystem = {
      # no i cant donate sorry
      no_donation_nag = true;
    };

    general = {
      # Resize windows by dragging borders
      resize_on_border = true;
    };

    # Monitor setup
    monitor = [
      # Main monitor in middle
      "DP-1, 1920x1080@144, 0x0, 1"

      # Laptop monitor on the right
      "eDP-1, 1920x1080@60, 1920x0, 1"
    ];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
  };
}
