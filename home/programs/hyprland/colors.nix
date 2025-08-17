{config, ...}: {
  # Generate a colors.conf file using Stylix base16 colors
  # This gets symlinked in default.nix
  home.file.".dotfiles/config/hypr/hyprland/colors.conf".text = ''
    col.bg0 = ${config.lib.stylix.colors.base00}
    col.bg1 = ${config.lib.stylix.colors.base01}
    col.bg2 = ${config.lib.stylix.colors.base02}
    col.bg3 = ${config.lib.stylix.colors.base03}
    col.fg0 = ${config.lib.stylix.colors.base05}
    col.fg1 = ${config.lib.stylix.colors.base06}
    col.fg2 = ${config.lib.stylix.colors.base07}
    col.red = ${config.lib.stylix.colors.base08}
    col.green = ${config.lib.stylix.colors.base0B}
    col.yellow = ${config.lib.stylix.colors.base0A}
    col.blue = ${config.lib.stylix.colors.base0D}
    col.magenta = ${config.lib.stylix.colors.base0E}
    col.cyan = ${config.lib.stylix.colors.base0C}
    col.orange = ${config.lib.stylix.colors.base09}
    col.active_border = ${config.lib.stylix.colors.base0C}
    col.inactive_border = ${config.lib.stylix.colors.base03}
    groupbar.col.active = ${config.lib.stylix.colors.base0C}
    groupbar.col.inactive = ${config.lib.stylix.colors.base03}
    groupbar.text_color = ${config.lib.stylix.colors.base05}
    shadow.color = ${config.lib.stylix.colors.base0C}99
    misc.background_color = ${config.lib.stylix.colors.base00}
  '';
}
