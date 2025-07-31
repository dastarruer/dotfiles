{config, ...}: {
  programs.waybar.style = ''
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
      border-radius: 5px;
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
      color: @blue;
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
}
