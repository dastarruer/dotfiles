{config, ...}: {
  programs.waybar.style = ''    /* -----------------------------------------------------
     *                      General
     * ----------------------------------------------------- */
    /* Colors */
    @define-color bg0_h rgba(29,32,33,0.85);
    @define-color bg  #282828;
    @define-color bg1 #3C3836;
    @define-color bg2 #504945;
    @define-color bg3 #665C54;
    @define-color fg  #EBDBB2;
    @define-color red #CC241D;
    @define-color blue #458588;
    @define-color purple #B16286;
    @define-color green #98971A;
    @define-color aqua #689D6A;
    @define-color yellow #D79921;
    @define-color orange #D65D0E;
    @define-color red1 #FB4934;

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

    /* -----------------------------------------------------
     *                      Tooltip
     * ----------------------------------------------------- */

    tooltip {
        background: @bg;
        border: solid 1px @bg3;
    }
    tooltip label {
        color: @fg;
    }

    /* -----------------------------------------------------
     *                      Window
     * ----------------------------------------------------- */

    window#waybar {
       /* background-color: rgba(16, 20, 25,0.5); */
       /* background-color: @bg; */
        background-color: transparent;

    }

    window#waybar.hidden {
        opacity: 0.2;
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
        color: @fg;
        padding: 0 5px;
    }

    button {
        border: None;
        padding: 0;
    }
    /* -----------------------------------------------------
     *                  Workspaces
     * ----------------------------------------------------- */

    #taskbar {
        background-color: @bg0_h;
        padding: 0px 0px;
        margin: 2px 2px 2px 2px;
    }

    #taskbar button {
        min-width: 20px;
        color: @red;
        font-weight: normal;
        padding: 0;
        margin: 3px 3px 3px 3px;
    }

    #taskbar button.active {
        color: @red1;
        background-color: @bg;
    }

    #taskbar button:hover {
        background-color: @bg1;
    }

    /* #taskbar button:first-child {
        border-radius: 5px 0 0 5px;
    }

    #taskbar button:last-child {
        border-radius: 0 5px 5px 0;
    } */

    /* -----------------------------------------------------
     *                      Modules
     * ----------------------------------------------------- */

    #cpu,
    #memory,
    #battery,
    #wireplumber,
    #tray,
    #battery.charging,
    #battery.plugged,
    #network {
        background-color: @bg0_h;
        color: @purple;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    /* #network.disconnected {
        color: @purple;
    } */

    #tray {
        background-color: @bg0_h;
        color: @fg;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    #clock {
        background-color: @bg0_h;
        color: @orange;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    #memory {
        background-color: @bg0_h;
        color: @aqua;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    #cpu {
        background-color: @bg0_h;
        color: @green;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    #battery {
        background-color: @bg0_h;
        color: @yellow;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    #wireplumber {
        background-color: @bg0_h;
        color: @blue;
        padding: 0px 15px;
        margin: 2px 2px 2px 2px;
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }


  '';
}
