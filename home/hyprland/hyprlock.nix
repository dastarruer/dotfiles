{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      # background = [
      #   {
      #     monitor = "";
      #     path = "${config.home.homeDirectory}/Pictures/wallpapers/gruvbox/computer.jpg";
      #     blur_passes = 1;
      #     contrast = 1;
      #     brightness = 0.5;
      #     vibrancy = 0.2;
      #     vibrancy_darkness = 0.2;
      #   }
      # ];

      general = {
        hide_cursor = true;
        grace = 0;
      };

      # input-field = [
      #   {
      #     monitor = "";
      #     size = "250, 60";
      #     outline_thickness = 2;
      #     dots_size = 0.2;
      #     dots_spacing = 0.35;
      #     dots_center = true;
      #     # outer_color = "rgba(0, 0, 0, 0)";
      #     # inner_color = "rgba(0, 0, 0, 0.2)";
      #     # font_color = "$foreground";
      #     fade_on_empty = false;
      #     rounding = -1;
      #     # check_color = "rgb(204, 136, 34)";
      #     placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
      #     hide_input = false;
      #     position = "0, -200";
      #     halign = "center";
      #     valign = "center";
      #   }
      # ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

      # image = [
      #   {
      #     monitor = "";
      #     path = "${config.home.homeDirectory}/.config/hypr/hitman.png";
      #     size = 100;
      #     border_size = 2;
      #     # border_color = "$foreground";
      #     position = "0, -100";
      #     halign = "center";
      #     valign = "center";
      #   }
      # ];
    };
  };
}
