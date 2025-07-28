{config, ...}: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      spacing = 0;
      height = 35;
      margin-top = 0;
      margin-right = 0;
      margin-bottom = 0;
      margin-left = 0;

      modules-left = [
        "custom/launcher"
        "group/utility"
        "custom/playerctl#backward"
        "custom/playerctl#play"
        "custom/playerctl#foward"
        "custom/playerlabel"
      ];

      modules-center = [
        "custom/weather"
        "hyprland/workspaces"
        "custom/swaync"
      ];

      modules-right = [
        "tray"
        "battery"
        "pulseaudio"
        "network"
        "clock"
      ];

      "hyprland/workspaces" = {
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
        interval = 20;
      };

      cpu = {
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base09}' >  </span> {usage}%";
        tooltip = false;
      };

      backlight = {
        format = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0A}' > 󰞏 </span> {percent}%";
        tooltip = false;
      };

      "custom/playerctl#play" = {
        exec = ''playerctl -a metadata --format '{"text": "{{artist}} - {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F'';
        format = "{icon}";
        format-icons = {
          Paused = "<span> </span>";
          Playing = "<span>󰏥 </span>";
          Stopped = "<span> </span>";
        };
        on-click = "playerctl play-pause";
        on-scroll-down = "wpctl set-volume @DEFAULT_SINK@ 5%-";
        on-scroll-up = "wpctl set-volume @DEFAULT_SINK@ 5%+";
        return-type = "json";
        format = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0D}' >  </span> {}";
      };

      pulseaudio = {
        format = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0C}' >  </span> {volume}%";
        format-muted = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base08}' >  </span> {volume}%";
        format-bluetooth = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base0D}' > 󰂰 </span> {volume}%";
        format-bluetooth-muted = "<span color='#202020' bgcolor='#${config.lib.stylix.colors.base08}' > 󰂲 </span> {volume}%";
        format-source = "{volume}% ";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        tooltip = false;
        max-volume = 130;
      };

      battery = {
        format = "{icon}  {capacity}%";
        format-alt = "{icon} {time}";
        format-charging = " {capacity}%";
        format-icons = ["" "" "" "" ""];
        format-plugged = " {capacity}% ";
        format-time = "{H} h {m} min";
        states = {
          critical = 15;
          good = 95;
          warning = 30;
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
        format-warning = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0A}'> {icon} </span> {capacity}%";
        format-full = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> {icon} </span> {capacity}%";
        format-charging = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> 󰂅 </span> {capacity}%";
        format-charging-warning = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0A}'> 󰢝 </span> {capacity}%";
        format-charging-critical = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base08}'> 󰢜 </span> {capacity}%";
        format-plugged = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> 󰂅 </span> {capacity}%";
        format-alt = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'> 󱧥 </span> {time}";

        tooltip = false;
      };

      clock = {
        format = "<span color='#${config.lib.stylix.colors.base00}' bgcolor='#${config.lib.stylix.colors.base0B}'>  </span> {:%a %d | %b %I:%M %p}";

        tooltip = false;
        interval = 1;
        tooltip-format = "<tt>{calendar}</tt>";
        calendar.format.today = "<span color='#fAfBfC'><b>{}</b></span>";
        actions = {
          on-click-right = "shift_down";
          on-click = "shift_up";
        };
      };
    }
  ];
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

