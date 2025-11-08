# Waybar from here: https://github.com/saatvik333/hyprland-dotfiles/blob/main/waybar/config
{config, ...}: {
  imports = [
    ./colors.nix
  ];

  programs.waybar = {
    enable = true;

    settings = {
      config = {
        layer = "bottom";
        position = "top";
        height = 30;
        spacing = 0;

        "modules-left" = [
          "hyprland/workspaces"
          "memory"
          "cpu"
        ];
        "modules-center" = [
          "custom/clock"
        ];
        "modules-right" = [
          "hyprland/language"
          "pulseaudio"
          "battery"
          "backlight"
          "tray"
        ];

        cpu = {
          interval = 10;
          format = "<span color='#${config.lib.stylix.colors.base09}'><b>cpu:</b></span> {usage}%<span color='#${config.lib.stylix.colors.base01}'> ] </span>";
        };

        memory = {
          interval = 10;
          format = "<span color='#${config.lib.stylix.colors.base01}'> [ </span><span color='#${config.lib.stylix.colors.base09}'><b>mem:</b></span> {percentage}%<span color='#${config.lib.stylix.colors.base01}'> / </span>";
          tooltip = true;
          tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB used";
        };

        "hyprland/workspaces" = {
          "disable-scroll" = true;
          format = "{icon}{name}";
          "format-icons" = {
            default = " ";
            urgent = "!";
            active = "*";
          };
        };

        "custom/clock" = {
          format = "<span color='#${config.lib.stylix.colors.base01}'>[ </span>{text}<span color='#${config.lib.stylix.colors.base01}'> ]</span>";
          exec = "date +'%I:%M %A, %b %d' | awk '{print tolower($0)}'";
          interval = 3;
        };

        "hyprland/language" = {
          format = "<span color='#${config.lib.stylix.colors.base01}'>[ </span><span color='#${config.lib.stylix.colors.base09}'><b>key: </b></span>{short}<span color='#${config.lib.stylix.colors.base01}'> / </span>";
          tooltip = false;
        };

        pulseaudio = {
          format = "<span color='#${config.lib.stylix.colors.base09}'><b>vol:</b></span> {volume}% </span>{short}<span color='#${config.lib.stylix.colors.base01}'> / </span>";
        };

        battery = {
          format = "<span color='#${config.lib.stylix.colors.base09}'><b>bat:</b></span> {capacity}%</span>{short}<span color='#${config.lib.stylix.colors.base01}'> / </span>";
          "format-charging" = "<span color='#${config.lib.stylix.colors.base09}'><b>ac:</b></span> {capacity}%</span>{short}<span color='#${config.lib.stylix.colors.base01}'> / </span>";
          "format-plugged" = "</span>{short}<span color='#${config.lib.stylix.colors.base01}'> / </span>";
          tooltip = false;
          interval = 20;
        };

        backlight = {
          format = "<span color='#${config.lib.stylix.colors.base09}'><b>mon:</b></span> {percent}%<span color='#${config.lib.stylix.colors.base01}'> ]</span>";
          tooltip = false;
        };

        tray = {
          "icon-size" = 20;
          spacing = 7;
          tooltip = false;
        };
      };
    };
  };
}
