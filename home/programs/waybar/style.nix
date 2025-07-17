{config, ...}: {
  programs.waybar.style = ''
    /* ================================ */
    /*            Stylix Colors         */
    /* ================================ */
    @define-color base      #${config.lib.stylix.colors.base00};
    @define-color mantle    #${config.lib.stylix.colors.base01};
    @define-color base  #${config.lib.stylix.colors.base02};
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

    /* Global Properties */
    * {
        border: none;
        border-radius: 0px;
        font-family: JetBrainsMono Nerd Font Propo;
        font-size: 16px;
        font-weight: 800;
        min-height: 0;
    }

    window#waybar {
      background-color: transparent;
      box-shadow: none;
    }

    #window {
        padding-left: 15px;
        padding-right: 15px;
        border-radius: 16px;
        margin-top: 5px;
        margin-bottom: 5px;
        font-weight: normal;
        font-style: normal;
    }

    tooltip {
        background: @base;
        border: 2px solid @teal;
        border-radius: 12px;
    }
    tooltip label {
        color: @text;
        padding: 6px;
    }

    #workspaces {
        background: @base;
        margin: 5px;
        padding: 8px 5px;
        border-radius: 16px;
        color: @text;
    }
    #workspaces button {
        font-weight: bold;
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 16px;
        color: transparent;
        background: @surface2;
    }
    #workspaces button.active {
        font-weight: bold;
        background-color: @blue;
        color: @mantle;
        min-width: 50px;
        background-size: 400% 400%;
    }
    #workspaces button:hover {
        background-color: @teal;
        color: @mantle;
    }
    #workspaces button.urgent {
        background-color: @red;
        color: @mantle;
    }

    #custom-swaync, #custom-weather {
        font-weight: bold;
        background: @base;
        margin: 5px;
        padding: 8px 16px;
        color: @text;
    }
    #custom-weather {
        border-radius: 24px 10px 24px 10px;
    }
    #custom-swaync {
        border-radius: 10px 24px 10px 24px;
    }

    #tray, #pulseaudio, #network, #battery, #cpu, #temperature, #custom-colorpicker, #memory, #custom-pacman, #idle_inhibitor,
    #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
        background: @base;
        font-weight: bold;
        margin: 5px 0px;
    }

    #tray, #pulseaudio, #network, #battery {
        color: @text;
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin-left: 7px;
    }

    #clock {
        color: @text;
        background: @base;
        border-radius: 0px 0px 0px 40px;
        padding: 10px 10px 15px 25px;
        margin-left: 7px;
        font-weight: bold;
        font-size: 14px;
    }

    #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
        font-size: 22px;
    }
    #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.foward:hover {
        color: @text;
    }
    #custom-playerctl.backward {
        color: @teal;
        border-radius: 24px 0px 0px 10px;
        padding-left: 16px;
        margin-left: 7px;
    }
    #custom-playerctl.play {
        color: @rosewater;
        padding: 0 5px;
    }
    #custom-playerctl.foward {
        color: @teal;
        border-radius: 0px 10px 24px 0px;
        padding-right: 12px;
        margin-right: 7px;
    }
    #custom-playerlabel {
        background: @base;
        color: @text;
        padding: 0 20px;
        border-radius: 24px 10px 24px 10px;
        margin: 5px 0;
        font-weight: bold;
    }

    #group-utility {
        padding: 0px 5px;
        transition: all .3s ease;
    }

    #custom-launcher {
        color: @blue;
        background: @base;
        margin: 0px 5px 0px 0px;
        padding: 0px 35px 0px 15px;
        border-radius: 0px 0px 40px 0px;
        font-size: 28px;
    }

    #custom-colorpicker, #cpu, #temperature, #memory, #custom-pacman, #idle_inhibitor {
        background: @base;
        font-size: 16px;
    }

    #cpu {
        color: @teal;
        border-radius: 24px 0px 0px 10px;
        padding-left: 16px;
        padding-right: 7px;
        margin-left: 7px;
    }

    #memory {
        color: @blue;
    }
    #temperature {
        color: @teal;
    }
    #custom-pacman {
        color: @blue;
    }
    #idle_inhibitor {
        color: @text;
    }
    #idle_inhibitor.activated {
        color: @red;
    }

    #temperature, #memory, #custom-pacman, #idle_inhibitor {
        padding-left: 7px;
        padding-right: 7px;
    }

    #custom-colorpicker {
        color: @teal;
        border-radius: 0px 10px 24px 0px;
        padding-right: 12px;
        padding-left: 7px;
        margin-right: 7px;
    }

    #custom-expand {
        background: transparent;
        color: @text;
        margin: 1px;
        font-size: 22px;
    }
    #custom-expand:hover {
        color: @blue;
    } '';
}
