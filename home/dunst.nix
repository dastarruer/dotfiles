{pkgs, ...}: {
  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
      size = "96x96";
    };

    settings = {
      global = {
        # Font & Appearance
        format = "<b>%s</b>\n%b";
        alignment = "center";
        word_wrap = true;
        ignore_newline = false;
        transparency = 10;
        corner_radius = 10;
        line_height = 0;
        separator_height = 2;
        frame_width = 2;

        # Icon Settings
        icon_theme = "Papirus-Dark";
        icon_corner_radius = 10;
        min_icon_size = 80;
        max_icon_size = 100;

        # Notification Behavior
        sort = true;
        indicate_hidden = true;
        show_age_threshold = 60;
        idle_threshold = 120;
        sticky_history = true;

        # Display & Positioning
        monitor = 0;
        follow = "mouse";
        padding = 10;
        horizontal_padding = 10;
        origin = "top-right";
      };

      urgency_low = {
        timeout = 5;
      };

      urgency_normal = {
        timeout = 5;
      };

      urgency_critical = {
        timeout = 0;
      };
    };
  };
}
