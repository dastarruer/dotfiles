{config, ...}: {
  # Define colors to be used by style.css
  # home.file.".cache/waybar/colors.css".text = ''
  #   /* ================================ */
  #   /*            Stylix Colors         */
  #   /* ================================ */
  #   @define-color foreground #${config.lib.stylix.colors.base05};
  #   @define-color background #${config.lib.stylix.colors.base00};

  #   @define-color color01 #${config.lib.stylix.colors.base08};
  #   @define-color color02 #${config.lib.stylix.colors.base09};
  #   @define-color color03 #${config.lib.stylix.colors.base0A};
  #   @define-color color04 #${config.lib.stylix.colors.base0B};
  #   @define-color color05 #${config.lib.stylix.colors.base0C};
  #   @define-color color06 #${config.lib.stylix.colors.base0D};
  #   @define-color color07 #${config.lib.stylix.colors.base0E};

  #   @define-color color08 #${config.lib.stylix.colors.base03};
  #   @define-color color09 #${config.lib.stylix.colors.base08};
  #   @define-color color10 #${config.lib.stylix.colors.base09};
  #   @define-color color11 #${config.lib.stylix.colors.base0A};
  #   @define-color color12 #${config.lib.stylix.colors.base0B};
  #   @define-color color13 #${config.lib.stylix.colors.base0C};
  #   @define-color color14 #${config.lib.stylix.colors.base0D};
  #   @define-color color15 #${config.lib.stylix.colors.base0F};
  # '';

  # home.file.".cache/waybar/colors.css".text = ''
  # '';
  programs.waybar.style = ''
    /* ================================ */
    /*            Stylix Colors         */
    /* ================================ */
    @define-color accent #${config.lib.stylix.colors.base09};
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
        font-family: "JetBrainsMono Nerd Font";
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
        font-family: "JetBrainsMono Nerd Font";
        color: @fg;
    }

    #workspaces {
        font-family: "JetBrainsMono Nerd Font";
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
