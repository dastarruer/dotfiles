{config, ...}: {
  # Generate the theme.rasi file
  home.file.".cache/rofi/theme.rasi".text = ''
    configuration {
      font: "${config.stylix.fonts.monospace.name} Medium 11";
    }

    * {
      /*
        We use full transparency here so that we can simiulate the effect where
        the height gets reduced. Difficult to explain, easier to understand when
        the config is used.
      */
      background-color: #00000000;
      text-color: #${config.lib.stylix.colors.base05};
    }

    inputbar {
      background-color: #${config.lib.stylix.colors.base00};
    }

    element {
      text-color: #${config.lib.stylix.colors.base05};
      background-color: #${config.lib.stylix.colors.base00};
    }

    element run {
      text-color: #${config.lib.stylix.colors.base05};
    }

    element-icon selected {
      background-color: #${config.lib.stylix.colors.base00};
    }

    element-text selected {
      text-color: #${config.lib.stylix.colors.base0C};
      background-color: #${config.lib.stylix.colors.base00};
    }
  '';
}
