{config, ...}: {
  programs.rofi.theme = let
    inherit (config.lib.formats.rasi) mkLiteral;
  in {
    "*" = {
      accent = mkLiteral "#${config.home-manager.theme.accent}";
      fg = mkLiteral "#${config.lib.stylix.colors.base05}";
      bg = mkLiteral "#${config.lib.stylix.colors.base00}";
      bg-alt = mkLiteral "#${config.lib.stylix.colors.base01}";

      background-color = mkLiteral "@bg";
      color = mkLiteral "@fg";
      border = 0;
      border-color = mkLiteral "@bg";
      margin = 0;
      padding = 0;
      spacing = 0;
      highlight = mkLiteral "none";
    };

    window = {
      width = mkLiteral "385px";
      border = 1;
      border-color = mkLiteral "@bg-alt";
    };

    element = {
      padding = mkLiteral "2px 4px 2px 4px";
      text-color = mkLiteral "@fg";
    };

    "element-text" = {
      vertical-align = mkLiteral "0.5";
      padding = 5;
    };

    "element-text selected" = {
      color = mkLiteral "@accent";
    };

    entry = {
      background-color = mkLiteral "@bg";
      columns = 1;
      lines = 20;
      border-color = mkLiteral "@accent";
    };

    inputbar = {
      children = [(mkLiteral "prompt") (mkLiteral "entry")];
      border = mkLiteral "0 0 1px 0";
      border-color = mkLiteral "@bg-alt";
      margin = mkLiteral "10px 10px 0 10px";
      padding = mkLiteral "0 0 5px 0";
    };

    prompt = {
      text-color = mkLiteral "@accent";
      font = "${config.stylix.fonts.sansSerif.name} Bold ${toString config.stylix.fonts.sizes.applications}";
    };

    listview = {
      background-color = mkLiteral "@bg";
      columns = 1;
      lines = 5;
    };
  };
}
