{config, ...}: {
  # Define colors to be used by style.css
  home.file.".cache/waybar/colors.css".text = ''
    /* ================================ */
    /*            Stylix Colors         */
    /* ================================ */
    @define-color foreground #${config.lib.stylix.colors.base05};
    @define-color background #${config.lib.stylix.colors.base00};

    @define-color color01 #${config.lib.stylix.colors.base08};
    @define-color color02 #${config.lib.stylix.colors.base09};
    @define-color color03 #${config.lib.stylix.colors.base0A};
    @define-color color04 #${config.lib.stylix.colors.base0B};
    @define-color color05 #${config.lib.stylix.colors.base0C};
    @define-color color06 #${config.lib.stylix.colors.base0D};
    @define-color color07 #${config.lib.stylix.colors.base0E};

    @define-color color08 #${config.lib.stylix.colors.base03};
    @define-color color09 #${config.lib.stylix.colors.base08};
    @define-color color10 #${config.lib.stylix.colors.base09};
    @define-color color11 #${config.lib.stylix.colors.base0A};
    @define-color color12 #${config.lib.stylix.colors.base0B};
    @define-color color13 #${config.lib.stylix.colors.base0C};
    @define-color color14 #${config.lib.stylix.colors.base0D};
    @define-color color15 #${config.lib.stylix.colors.base0F};
  '';
}
