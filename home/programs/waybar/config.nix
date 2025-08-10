{config, ...}: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 20;
      spacing = 5;
      margin-top = 5;
      margin-right = 8;
      margin-left = 8;

    settings = [
      {
        layer = "bottom";
        position = "top";
        # spacing = 4; # Optional spacing, uncomment if needed
        height = 35; # Remove for auto height

      modules-center = ["clock"];

      modules-right = [
        "disk"
        "cpu"
        "backlight"
        "custom/memory"
        "pulseaudio"
        "battery"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        active-only = false;
        all-outputs = true;
        warp-on-scroll = false;
        format = "{name}";
      };

      "hyprland/window" = {
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0E}' > 󰣆 </span> {class}";
        separate-outputs = true;
        icon = false;
      };

      tray = {
        icon-size = 15;
        spacing = 8;
      };

      disk = {
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base08}' >  </span> {free}";
        interval = 120;
      };

      cpu = {
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base09}' >  </span> {usage}%";
        tooltip = false;
        interval = 5;
      };

      backlight = {
        format = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0A}' > 󰞏 </span> {percent}%";
        tooltip = false;
      };

      "custom/memory" = {
        exec = "~/bin/memory_usage.sh";
        interval = 2;
        return-type = "json";
        format = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0D}' >  </span> {}";
      };

      pulseaudio = {
        format = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0C}' >  </span> {volume}%";
        format-muted = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0C}' >  </span> {volume}%";
        format-bluetooth = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0C}' > 󰂰 </span> {volume}%";
        format-bluetooth-muted = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0C}' > 󰂲 </span> {volume}%";
        format-source = "{volume}% ";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        tooltip = false;
        max-volume = 130;
      };

      "battery#bat2".bat = "BAT2";

      battery = {
        interval = 5;
        states = {
          good = 99;
          warning = 30;
          critical = 20;
        };
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> {icon} </span> {capacity}%";
        format-critical = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base08}'> {icon} </span> {capacity}%!!";
        format-warning = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base09}'> {icon} </span> {capacity}%";
        format-full = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> {icon} </span> {capacity}%";
        format-charging = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> 󰂅 </span> {capacity}%";
        format-charging-warning = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base09}'> 󰢝 </span> {capacity}%";
        format-charging-critical = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base08}'> 󰢜 </span> {capacity}%";
        format-plugged = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> 󰂅 </span> {capacity}%";
        format-alt = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> 󱧥 </span> {time}";

        tooltip = false;
      };

      clock = {
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'>  </span> {:%a %d %b | %I:%M %p}";

        tooltip = false;
        interval = 60;
      };
    };
  };
}
# unused
# "custom/rofi" = {
#   format = "";
#   on-click = "rofi -show drun -disable-history -show-icons";
#   # on-click-right = "~/.config/waybar/scripts/power.sh";
#   escape = true;
#   tooltip = false;
# };
# "sway/workspaces" = {
#   disable-scroll = true;
#   active-only = false;
#   all-outputs = true;
#   warp-on-scroll = false;
#   format = "{icon}";
#   format-icons = {
#     "1" = "󰧨";
#     "2" = "󰈹";
#     "3" = "";
#     "4" = "";
#     "5" = "";
#     "6" = "󰭛";
#     "7" = "󱓷";
#     "8" = "󰚀";
#   };
# };
# "sway/window" = {
#   format = "󰣆 {app_id}";
#   separate-outputs = true;
#   icon = false;
# };
# temperature = {
#   tooltip = false;
#   thermal-zone = 2;
#   hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
#   critical-threshold = 70;
#   format = "󰴈 {temperatureC}°C";
#   format-critical = " {temperatureC}°C";
# };

