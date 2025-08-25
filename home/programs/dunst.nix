{
  pkgs,
  config,
  ...
}: {
  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
      size = "96x96";
    };

    settings = {
      global = {
        # Appearance
        format = "<b>%s</b>\n%b";
        alignment = "center";
        word_wrap = true;
        ignore_newline = false;
        transparency = 10;
        corner_radius = 0;
        line_height = 0;
        separator_height = 2;
        frame_width = 2;

        # Icon Settings
        icon_theme = "Papirus-Dark";
        icon_corner_radius = 0;
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

      # Play an alert sound for all notifications
      play_sound = {
        summary = "*";
        #
        script = "${config.home.homeDirectory}/.config/dunst/alert.sh";
      };
    };
  };

  # Symlink the files used to play an alert for every notification
  home.file = {
    # This file comes from: https://mixkit.co/free-sound-effects/notification/
    ".config/dunst/alert.wav".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/dunst/alert.wav";

    ".config/dunst/alert.sh".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/dunst/alert.sh";
  };
}
