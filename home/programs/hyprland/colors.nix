{config, ...}: {
  # Generate a colors.conf file using Stylix base16 colors
  home.file.".cache/hypr/colors.conf".text = ''
    general {
      col.active_border = rgb(${config.lib.stylix.colors.base05})
      col.inactive_border = rgb(${config.lib.stylix.colors.base03})
    }
  '';
}
