{config, ...}: {
  programs.waybar.style = ''
    /* ================================ */
    /*            Stylix Colors         */
    /* ================================ */
    @define-color accent #${config.home-manager.theme.accent};
    @define-color fg #${config.lib.stylix.colors.base05};
    @define-color bg #${config.lib.stylix.colors.base00};
    @define-color bg-alt #${config.lib.stylix.colors.base01};

    * {
        font-size: 15px;
        min-height: 0;
    }

    window#waybar {
        background-color: @bg;
        border-bottom: 0px solid @bg-alt;
    }

    #mode {
        font-family: "${config.stylix.fonts.monospace.name}", monospace;
        font-weight: bold;
        color: @accent;
    }

    #language,
    #pulseaudio,
    #battery,
    #backlight,
    #custom-clock,
    #cpu,
    #memory {
        font-family: "${config.stylix.fonts.monospace.name}", monospace;
        color: @fg;
    }

    #workspaces {
        font-family: "${config.stylix.fonts.monospace.name}", monospace;
        border-bottom: 1px solid @bg-alt;
    }

    #workspaces button {
        padding: 7px 12px 7px 12px;
        color: @fg;
        background-color: @bg;
        border: none;
    }

    #workspaces button:hover {
        background: none;
        border: none;
        border-color: transparent;
        transition: none;
    }

    #workspaces button.focused {
        border-radius: 0;
        color: @accent;
        font-weight: bold;
    }

    #tray {
        font-family: "Ubuntu";
        padding-right: 5px;
        padding-left: 10px;
    }

  '';
}
