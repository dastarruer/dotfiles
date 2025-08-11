{config, ...}: {
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        margin = "8px 8px 0 8px";

        modules-left = [
          # "custom/arch"
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
          "mpris"
        ];

        modules-right = [
          "tray"
          "group/sys-resources"
          "privacy"
          # "network"
          # "bluetooth"
          # "pulseaudio#microphone"
          "group/audio"
          "group/brightness"
          "battery"
          # "custom/power"
        ];

        "group/sys-resources" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 400;
            children-class = "sys-resources";
            transition-left-to-right = false;
          };
          modules = [
            "custom/sys-resources"
            "cpu"
            "custom/memory"
            "disk"
          ];
        };

        "group/brightness" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 400;
            children-class = "brightness";
            transition-left-to-right = false;
          };
          modules = [
            "backlight"
            "backlight/slider"
          ];
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 400;
            children-class = "audio";
            transition-left-to-right = false;
          };
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
        };

        "custom/arch" = {
          format = "  btw";
          tooltip = false;
          on-click = "alacritty";
          on-click-right = "";
        };

        "hyprland/workspaces" = {
          format = "{id}";
          format-icons = {
            urgent = "*";
            special = "";
          };
          sort-by-number = true;
          all-outputs = true;
          persistent_workspaces."*" = 4;
        };

        clock = {
          interval = 60;
          format = "{:%I:%M %p}";
          format-alt = "{:%a, %b %d}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          on-click = "swaync-client -op";
        };

        mpris = {
          format = "{player_icon} {status_icon}";
          format-paused = "{player_icon} {status_icon}";
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
          player-icons = {
            default = "";
            spotify_player = "";
            spotify = "";
            firefox = "";
            chrome = "";
            vlc = "嗢";
          };
          max-length = 30;
          return-type = "json";
          interval = 1;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
          tooltip = false;
        };

        tray = {
          icon-size = 14;
          spacing = 8;
        };

        privacy = {
          icon-spacing = 8;
          icon-size = 14;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };

        disk = {
          format = " {free}";
          interval = 120;
        };

        cpu = {
          format = " {usage}%";
          tooltip = false;
          interval = 5;
        };

        "custom/memory" = {
          exec = "~/bin/memory_usage.sh";
          interval = 2;
          return-type = "json";
          format = " {}";
        };

        "custom/sys-resources" = {
          format = "󰘚";
          tooltip = false;
        };

        "custom/updates" = {
          format = "  {}";
          escape = true;
          return-type = "json";
          exec = "~/.config/scripts/system/package-updates.sh";
          interval = 1800;
          on-click = "alacritty -e yay -Syu --noconfirm";
        };

        network = {
          format-icons = {
            wifi = [
              "睊"
              "直"
              "盛"
              "瘟"
            ];
            ethernet = "";
            disabled = "睊";
            disconnected = "盛";
          };
          format-wifi = "{icon}";
          format-ethernet = "{icon} Wired";
          format-disconnected = "{icon}";
          format-disabled = "{icon}";
          interval = 5;
          tooltip-format = "{essid}\t{gwaddr}\n{bandwidthUpBytes} 󰁝\t{bandwidthDownBytes} 󰁅";
          on-click = "rfkill toggle wifi";
          on-click-right = "alacritty -e nmtui";
          tooltip = true;
          max-length = 20;
        };

        bluetooth = {
          interval = 5;
          format-on = "";
          format-off = ""; # reuse same icon for disabled/off
          format-disabled = "";
          format-connected = "";
          tooltip = true;
          tooltip-format = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias} {device_battery_percentage}%";
          on-click = "rfkill toggle bluetooth";
          on-click-right = "blueman-manager";
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        pulseaudio = {
          interval = 1;
          format = "{icon}";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click-right = "pavucontrol";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-scroll-up = "";
          on-scroll-down = "";
          tooltip = true;
          tooltip-format = "Volume: {volume}%\n{desc}";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "";
          format-source-muted = "";
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          tooltip = false;
        };

        "backlight/slider" = {
          min = 5;
          max = 100;
          orientation = "horizontal";
          device = "amdgpu_bl1"; # Get this by running `ls /sys/class/backlight/`
        };

        backlight = {
          device = "amdgpu_bl1"; # Get this by running `ls /sys/class/backlight/`
          format = "{icon}";
          format-icons = [
            "󰞏"
          ];
          on-scroll-up = "";
          on-scroll-down = "";
          tooltip = false;
        };

        battery = {
          interval = 10;
          states = {
            warning = 20;
            critical = 10;
            plugordie = 5;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";

          # Show time til battery runs out on click
          format-alt = "󱧥 {time}";

          tooltip = false;
          exec-on-event = true;
          exec-if-event = "state-warning, state-critical";
          # exec = "~/.config/scripts/battery-notification.sh {capacity}";
        };

        "custom/power" = {
          format = "";
          on-click = "wlogout --protocol layer-shell -b 2";
          tooltip = false;
        };
      }
    ];
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

