{config, ...}: {
  # Generate the theme.rasi file
  home.file.".dotfiles/config/rofi/themes/theme.rasi".text = ''
    * {
      main-bg:    ${config.lib.stylix.colors.base00};
      main-fg:    ${config.lib.stylix.colors.base05};
      main-br:    ${config.lib.stylix.colors.base0A};
      main-ex:    ${config.lib.stylix.colors.base0D};
      select-bg:  ${config.lib.stylix.colors.base0F};
      select-fg:  ${config.lib.stylix.colors.base03};
    }
  '';
}
