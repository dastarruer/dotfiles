{config, ...}: {
  # Generate the theme.rasi file
  home.file.".cache/rofi/theme.rasi".text = ''
    configuration {
      font: "${config.stylix.fonts.monospace.name} Medium 12";
    }

    * {
      accent: #${config.lib.stylix.colors.base09};
      fg: #${config.lib.stylix.colors.base05};
      bg: #${config.lib.stylix.colors.base00};
      bg-alt: #${config.lib.stylix.colors.base01};
    }
  '';
}
