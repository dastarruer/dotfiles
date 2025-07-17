{...}: {
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "bottom";
        position = "top";
        # spacing = 4; # Optional spacing, uncomment if needed
        height = 35; # Remove for auto height

        modules-left = ["tray"];
        modules-center = ["clock"];
        modules-right = [
          "battery"
          "cpu"
          "memory"
          "wireplumber"
          "network"
        ];

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 16;
          icon-theme = "Gruvbox Plus Dark";
          on-click = "minimize-raise";
          app_ids-mapping = {
            "org.gnome.FileRoller" = "FileRoller";
            "org.pwmt.zathura" = "zathura";
            "com.github.johnfactotum.Foliate" = "foliate";
          };
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        battery = {
          bat = "BAT0";
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
          max-length = 25;
        };

        cpu = {
          format = "CPU: {usage}%";
          tooltip = false;
        };

        memory = {
          format = "RAM: {used:0.1f}GB";
          tooltip = false;
        };

        network = {
          # interface = "wlp2*"; # Optional, uncomment if needed
          format-wifi = "({signalStrength}%) ";
          format-ethernet = "󰈀";
          tooltip-format = "{ipaddr}\n<b>up:</b> {bandwidthUpBytes} <b>down:</b> {bandwidthDownBytes}";
          format-linked = "{ifname} (No IP) ?";
          format-disconnected = "No connection";
          on-click = "networkmanager_dmenu";
          on-click-right = "\${TERMINAL} -a floatterm -e nethogs";
        };

        wireplumber = {
          format = "{icon} : {volume}%";
          format-muted = "";
          format-icons = ["" " "];
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        clock = {
          format = "{:%b %d %H:%M}";
          tooltip-format = "<span color='#FFFFFF'><tt>{calendar}</tt></span>";
          calendar = {
            "mode-mon-col" = 4;
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span color='#BE95FF'><b>{}</b></span>";
              weeks = "<span color='#525252'><b>{}</b></span>";
              weekdays = "<span color='#78A9FF'><b>{}</b></span>";
              today = "<span color='#BE95FF' background='#161616'><b>{}</b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
          tooltip = true;
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

