{config, ...}: {
  programs.waybar.style = ''
    /* ================================ */
    /*            Stylix Colors         */
    /* ================================ */
    @define-color foreground #${config.lib.stylix.colors.base05};
    @define-color background #${config.lib.stylix.colors.base00};

    @define-color color01 #${config.lib.stylix.colors.base08};
    @define-color color02 #${config.lib.stylix.colors.base0B};
    @define-color color03 #${config.lib.stylix.colors.base0A};
    @define-color color04 #${config.lib.stylix.colors.base0D};
    @define-color color05 #${config.lib.stylix.colors.base0E};
    @define-color color06 #${config.lib.stylix.colors.base0C};
    @define-color color07 #${config.lib.stylix.colors.base05};

    @define-color color08 #${config.lib.stylix.colors.base03};
    @define-color color09 #${config.lib.stylix.colors.base08};
    @define-color color10 #${config.lib.stylix.colors.base0B};
    @define-color color11 #${config.lib.stylix.colors.base0A};
    @define-color color12 #${config.lib.stylix.colors.base0D};
    @define-color color13 #${config.lib.stylix.colors.base0E};
    @define-color color14 #${config.lib.stylix.colors.base0C};
    @define-color color15 #${config.lib.stylix.colors.base07};


    /* ======================= */
    /* Global Styles           */
    /* ======================= */
    * {
        border: none;
        font-family: JetBrainsMono Nerd Font Propo;
        font-size: 16px;
        box-shadow: none;
        min-width: 28px;
        min-height: 28px;
    }

    window#waybar {
        background: transparent;
    }

    /* ======================= */
    /* Interactive States      */
    /* ======================= */
    #custom-updates:hover,
    #power-profiles-daemon:hover,
    #network:hover,
    #bluetooth:hover,
    #pulseaudio:hover,
    #backlight:hover,
    #custom-power:hover,
    #pulseaudio.microphone:hover,
    #pulseaudio.sink-muted:hover {
        opacity: 0.8;
    }

    /* ======================= */
    /* Custom Widgets          */
    /* ======================= */
    #custom-nix {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 14px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    /* ======================= */
    /* Workspace Management    */
    /* ======================= */
    #workspaces {
        margin: 0;
        padding: 0;
    }

    #workspaces button {
        color: @foreground;
        padding: 0 8px;
        margin: 0 4px;
        /* border: solid 2px transparent; */
        border-radius: 8px;
    }

    #workspaces button.active {
        color: @foreground;
        /* border: solid 2px @foreground; */
        background: rgba(255, 255, 255, 0.1);
    }

    @keyframes urgent-pulse {
        0% { opacity: 0.5; }
        100% { opacity: 1; }
        50% { opacity: 0.5; }
    }

    /* ======================= */
    /* System Components       */
    /* ======================= */
    #clock {
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        font-weight: 500;
    }


    #mpris {
        color: @foreground;
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 8px;
        background: rgba(255, 255, 255, 0.1);
    }

    #mpris.playing {
        color: @color02;
        background: rgba(255, 255, 255, 0.1);
    }

    #mpris.paused {
        color: @color03;
        background: rgba(255, 255, 255, 0.1);
    }

    #mpris.stopped {
        color: @color01;
        background: rgba(255, 255, 255, 0.1);
    }

    #custom-monitors {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 8px;
    }

    #cpu,
    #disk,
    #custom-memory {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 8px;
    }

    /* ======================= */
    /* System Indicators       */
    /* ======================= */
    #tray {
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #privacy {
        background: rgba(0, 0, 0, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @color03; */
        border-radius: 8px;
    }

    #privacy-item {
        color: @color03;
    }

    /* ======================= */
    /* Menu                    */
    /* ======================= */

    #custom-sys-resources {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 8px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    tooltip class {
        color: @foreground;
    }

    #custom-updates {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    /* Green class - no updates or low count */
    #custom-updates.green {
        color: @color02;
        background: rgba(0, 255, 0, 0.1);
    }

    /* Yellow class - moderate updates */
    #custom-updates.yellow {
        color: @color03;
        background: rgba(255, 255, 0, 0.1);
    }

    /* Red class - many updates */
    #custom-updates.red {
        color: @color01;
        background: rgba(255, 0, 0, 0.1);
    }

    #power-profiles-daemon {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #power-profiles-daemon.performance {
        color: @color01;
        /* border: solid 2px @color01; */
        background: rgba(255, 0, 0, 0.1);
    }

    #power-profiles-daemon.balanced {
        color: @color03;
        /* border: solid 2px @color03; */
        background: rgba(255, 255, 255, 0.1);
    }

    #power-profiles-daemon.power-saver {
        color: @color02;
        /* border: solid 2px @color02; */
        background: rgba(0, 255, 0, 0.1);
    }


    /* ======================= */
    /* Network & Bluetooth     */
    /* ======================= */
    #network {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #bluetooth {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #network.disabled {
        color: @color01;
        /* border: solid 2px @color01; */
        background: rgba(255, 0, 0, 0.1);
    }

    #bluetooth.disabled {
        color: @color08;
        /* border: solid 2px @color08; */
        background: rgba(0, 0, 255, 0.1);
    }

    /* ======================= */
    /* Audio Controls          */
    /* ======================= */

    #pulseaudio {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #pulseaudio.sink-muted {
        color: @color03;
        /* border: solid 2px @color03; */
        background: rgba(255, 255, 0, 0.1);
    }

    #pulseaudio.microphone {
        color: @foreground;
        /* border: solid 2px @foreground; */
        background: rgba(255, 255, 255, 0.1);
    }

    #pulseaudio.microphone.source-muted {
        color: @color01;
        /* border: solid 2px @color01; */
        background: rgba(255, 0, 0, 0.1);
    }

    #pulseaudio-slider {
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 8px;
    }

    #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        background: transparent;
        box-shadow: none;
    }
    #pulseaudio-slider trough {
        min-height: 8px;
        min-width: 100px;
        border-radius: 4px;
        background-color: rgba(255, 255, 255, 0.2);
    }
    #pulseaudio-slider highlight {
        min-width: 8px;
        min-height: 8px;
        border-radius: 4px;
        background: @color06;
    }

    /* ======================= */
    /* Hardware Controls       */
    /* ======================= */
    #backlight {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #backlight-slider {
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 8px;
    }

    #backlight-slider slider {
        min-height: 0px;
        min-width: 0px;
        background: transparent;
        box-shadow: none;
    }
    #backlight-slider trough {
        min-height: 8px;
        min-width: 100px;
        border-radius: 4px;
        background: rgba(255, 255, 255, 0.2);
    }
    #backlight-slider highlight {
        min-width: 8px;
        min-height: 8px;
        border-radius: 4px;
        background: @color09;
    }

    /* ======================= */
    /* Battery                 */
    /* ======================= */
    #battery {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        padding: 0 12px;
        margin: 0 4px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

    #battery.charging {
        color: @color02;
        /* border: solid 2px @color02; */
    }

    #battery.warning {
        color: @color03;
        /* border: solid 2px @color03; */
    }

    #battery.critical,
    #battery.plugordie {
        color: @color01;
        /* border: solid 2px @color01; */
    }

    /* ======================= */
    /* Power Menu              */
    /* ======================= */
    #custom-power {
        color: @foreground;
        background: rgba(255, 255, 255, 0.1);
        margin: 0 4px;
        padding: 0 12px;
        /* border: solid 2px @foreground; */
        border-radius: 8px;
    }

  '';
}
