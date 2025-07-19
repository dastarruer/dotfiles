{...}: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 20;
      spacing = 5;
      margin-top = 5;
      margin-right = 8;
      margin-left = 8;

      modules-left = [
        "hyprland/workspaces"
        "tray"
        "hyprland/window"
      ];

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
        format = "󰣆 {class}";
        separate-outputs = true;
        icon = false;
      };

      tray = {
        icon-size = 15;
        spacing = 8;
      };

      disk = {
        format = " {free}";
        interval = 20;
      };

      cpu = {
        format = " {usage}%";
        tooltip = false;
        interval = 1;
      };

      backlight = {
        format = "󰞏 {percent}%";
        tooltip = false;
      };

      "custom/memory" = {
        exec = "~/bin/memory_usage.sh";
        interval = 2;
        return-type = "json";
        format = " {}";
      };

      pulseaudio = {
        format = " {volume}%";
        format-muted = " {volume}%";
        format-bluetooth = "󰂰 {volume}%";
        format-bluetooth-muted = "󰂲 {volume}%";
        format-source = "{volume}% ";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        tooltip = false;
        max-volume = 130;
      };

      "battery#bat2".bat = "BAT2";

      battery = {
        interval = 1;
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
        format = "{icon} {capacity}%";
        format-critical = "{icon} {capacity}%!!";
        format-warning = "{icon} {capacity}%";
        format-full = "{icon} {capacity}%";
        format-charging = "󰂅 {capacity}%";
        format-charging-warning = "󰢝 {capacity}%";
        format-charging-critical = "󰢜 {capacity}%";
        format-plugged = "󰂅 {capacity}%";
        format-alt = "󱧥 {time}";
        tooltip = false;
      };

      clock = {
        format = " {:%a %d %b %I:%M %p}";
        tooltip = false;
        interval = 1;
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

