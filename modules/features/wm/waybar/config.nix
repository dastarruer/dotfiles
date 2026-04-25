# Waybar from here: https://github.com/martin-djakovic/dotfiles
{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
      programs.waybar.settings = {
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
            "network"
          ];

          cpu = {
            interval = 10;
            format = "<span color='#${config.custom.theme.accent}'><b>cpu:</b></span> {usage}%<span color='#${config.lib.stylix.colors.base01}'> ] </span>";
          };

          memory = {
            interval = 10;
            format = "<span color='#${config.lib.stylix.colors.base01}'> [ </span><span color='#${config.custom.theme.accent}'><b>mem:</b></span> {percentage}%<span color='#${config.lib.stylix.colors.base01}'> / </span>";
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
            format = "<span color='#${config.lib.stylix.colors.base01}'>[ </span><span color='#${config.custom.theme.accent}'><b>key: </b></span>{short}<span color='#${config.lib.stylix.colors.base01}'> / </span>";
            tooltip = false;
          };

          pulseaudio = {
            format = "<span color='#${config.custom.theme.accent}'><b>vol:</b></span> {volume}%<span color='#${config.lib.stylix.colors.base01}'> / </span>";
          };

          battery = {
            bat = "BAT0";
            "format" = "<span color='#${config.custom.theme.accent}'><b>bat:</b></span> {capacity}%<span color='#${config.lib.stylix.colors.base01}'> / </span>";
            "format-charging" = "<span color='#${config.custom.theme.accent}'><b>ac:</b></span> {capacity}%<span color='#${config.lib.stylix.colors.base01}'> / </span>";
            "format-plugged" = "";
            tooltip = true;
            tooltip-format = "{timeTo}";
            interval = 5;
          };

          backlight = {
            format = "<span color='#${config.custom.theme.accent}'><b>mon:</b></span> {percent}%<span color='#${config.lib.stylix.colors.base01}'> / </span>";
            tooltip = false;
          };

          network = {
            interface = "wlp2s0";
            format = "<span color='#${config.custom.theme.accent}'><b>net:</b></span> {essid}<span color='#${config.lib.stylix.colors.base01}'> ]</span>";
            format-disconnected = "<span color='#${config.custom.theme.accent}'><b>net:</b></span> disconnected<span color='#${config.lib.stylix.colors.base01}'> ]</span>";
            format-disabled = "<span color='#${config.custom.theme.accent}'><b>net:</b></span> disconnected<span color='#${config.lib.stylix.colors.base01}'> ]</span>";
            max-length = 50;

            tooltip-format = "{essid} ({signalStrength}%) ";
            tooltip-format-disconnected = "Disconnected ({signalStrength}%) 󰖪";
            tooltip-format-disabled = "Disconnected ({signalStrength}%) 󰖪";

            # Run custom wifi script from networking.nix
            on-click = "${lib.getExe pkgs.wifi}";
          };
        };
      };
    };
  };
}
