{config, ...}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        height = 20;
        spacing = 5;
        margin-top = 5;
        margin-right = 8;
        margin-left = 8;

        modules-left = [
          "sway/workspaces"
          "sway/window"
          "hyprland/workspaces"
          "tray"
          "hyprland/window"
        ];

        modules-center = ["clock"];

        modules-right = [
          "disk"
          "cpu"
          "temperature"
          "backlight"
          "custom/memory"
          "pulseaudio"
          "battery"
        ];

        "custom/rofi" = {
          format = "";
          on-click = "rofi -show drun -disable-history -show-icons";
          # on-click-right = "~/.config/waybar/scripts/power.sh";
          escape = true;
          tooltip = false;
        };

        "sway/workspaces" = {
          disable-scroll = true;
          active-only = false;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "󰧨";
            "2" = "󰈹";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "󰭛";
            "7" = "󱓷";
            "8" = "󰚀";
          };
        };

        "sway/window" = {
          format = "󰣆 {app_id}";
          separate-outputs = true;
          icon = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          active-only = false;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {default = "";};
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

        temperature = {
          tooltip = false;
          thermal-zone = 2;
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 70;
          format = "󰴈 {temperatureC}°C";
          format-critical = " {temperatureC}°C";
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

    style = ''
            /* ================================ */
      /*            Stylix Colors         */
      /* ================================ */
      @define-color base      #${config.lib.stylix.colors.base00};
      @define-color mantle    #${config.lib.stylix.colors.base01};
      @define-color surface0  #${config.lib.stylix.colors.base02};
      @define-color surface1  #${config.lib.stylix.colors.base03};
      @define-color surface2  #${config.lib.stylix.colors.base04};
      @define-color text      #${config.lib.stylix.colors.base05};
      @define-color rosewater #${config.lib.stylix.colors.base06};
      @define-color lavender  #${config.lib.stylix.colors.base07};
      @define-color red       #${config.lib.stylix.colors.base08};
      @define-color peach     #${config.lib.stylix.colors.base09};
      @define-color yellow    #${config.lib.stylix.colors.base0A};
      @define-color green     #${config.lib.stylix.colors.base0B};
      @define-color teal      #${config.lib.stylix.colors.base0C};
      @define-color blue      #${config.lib.stylix.colors.base0D};
      @define-color mauve     #${config.lib.stylix.colors.base0E};
      @define-color flamingo  #${config.lib.stylix.colors.base0F};

      /* ================================ */
      /*            Common CSS            */
      /* ================================ */
      * {
        padding: 0;
        margin: 0;
        min-height: 0;
        border-radius: 0;
        border: none;
        text-shadow: none;
        transition: none;
        box-shadow: none;
      }

      /* The whole window */
      window#waybar {
        color: @rosewater;
        background: none;
      }

      window#waybar.hidden {
        opacity: 1;
      }

      #custom-rofi,
      #workspaces button,
      #workspaces button:hover,
      #workspaces button.visible,
      #workspaces button.visible:hover,
      #workspaces button.active,
      #workspaces button.active:hover,
      #workspaces button.urgent,
      #window,
      #tray,
      #disk,
      #cpu,
      #temperature,
      #temperature.critical,
      #backlight,
      #custom-memory,
      #pulseaudio,
      #pulseaudio.muted,
      #battery,
      #battery.critical,
      #battery.warning,
      #clock {
        font-family: JetBrainsMono Nerd Font Propo;
        font-size: 16px;
        font-weight: 800;
        color: @base;
        background: @base;
        border: 3px solid @base;
        border-radius: 3px;
      }

      #window,
      #tray,
      #disk,
      #cpu,
      #temperature,
      #temperature.critical,
      #backlight,
      #custom-memory,
      #pulseaudio,
      #pulseaudio.muted,
      #battery,
      #battery.critical,
      #battery.warning,
      #clock {
        padding-right: 4px;
      }

      #custom-rofi {
        background: @teal;
        padding: 0 6px;
      }

      /* ================================ */
      /*       workspaces module          */
      /* ================================ */
      #workspaces {
        margin: 0px;
      }

      #workspaces button {
        color: @rosewater;
        padding: 0 4px;
        margin: 0px 3px;
        min-width: 25px;
      }

      #workspaces button:hover {
        background: @mauve;
      }

      #workspaces button.visible {
        background: @green;
      }

      #workspaces button.visible:hover {
        background: @green;
      }

      #workspaces button.active {
        background: @green;
      }

      #workspaces button.active:hover {
        background: @green;
      }

      #workspaces button.urgent {
        background: @red;
      }

      /* ================================ */
      /*            window                */
      /* ================================ */
      #window {
        color: @mauve;
      }

      /* ================================ */
      /*            tray                  */
      /* ================================ */
      #tray {
        padding: 0 6px;
      }

      /* ================================ */
      /*            disk                  */
      /* ================================ */
      #disk {
        color: @red;
      }

      /* ================================ */
      /*            cpu                   */
      /* ================================ */
      #cpu {
        color: @peach;
      }

      /* ================================ */
      /*          temperature             */
      /* ================================ */
      #temperature {
        color: @yellow;
      }

      #temperature.critical {
        color: @red;
      }

      /* ================================ */
      /*          backlight               */
      /* ================================ */
      #backlight {
        color: @yellow;
      }

      /* ================================ */
      /*          memory                  */
      /* ================================ */
      #custom-memory {
        color: @blue;
      }

      /* ================================ */
      /*         pulseaudio               */
      /* ================================ */
      #pulseaudio {
        color: @teal;
      }

      #pulseaudio.muted {
        color: @red;
      }

      /* ================================ */
      /*            battery               */
      /* ================================ */
      #battery {
        color: @green;
      }

      #battery.critical {
        color: @red;
      }

      #battery.warning {
        color: @peach;
      }

      /* ================================ */
      /*            clock                 */
      /* ================================ */
      #clock {
        color: @green;
      }

    '';
  };
}
