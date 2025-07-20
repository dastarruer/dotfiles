{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  # Spicetify themes
  programs.spicetify = {
    theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.themes.onepunch;

    customColorScheme = {
      accent = "${config.lib.stylix.colors.base00}";
      accentActive = "${config.lib.stylix.colors.base02}";
      accentInactive = "${config.lib.stylix.colors.base03}";
      banner = "${config.lib.stylix.colors.base04}";
      borderActive = "${config.lib.stylix.colors.base05}";
      borderInactive = "${config.lib.stylix.colors.base05}";
      header = "${config.lib.stylix.colors.base05}";
      highlight = "${config.lib.stylix.colors.base06}";
      main = "${config.lib.stylix.colors.base00}";
      notification = "${config.lib.stylix.colors.base07}";
      notificationError = "${config.lib.stylix.colors.base08}";
      subtext = "${config.lib.stylix.colors.base05}";
      text = "${config.lib.stylix.colors.base05}";
      extratext = "${config.lib.stylix.colors.base05}";
      sidebar = "${config.lib.stylix.colors.base00}";
      player = "${config.lib.stylix.colors.base00}";
      secPlayer = "${config.lib.stylix.colors.base04}";
      card = "${config.lib.stylix.colors.base02}";
      secCard = "${config.lib.stylix.colors.base03}";
      shadow = "${config.lib.stylix.colors.base01}";
      selectedRow = "${config.lib.stylix.colors.base02}";
      button = "${config.lib.stylix.colors.base04}";
      buttonActive = "${config.lib.stylix.colors.base05}";
      buttonDisabled = "${config.lib.stylix.colors.base01}";
      tabActive = "${config.lib.stylix.colors.base06}";
      misc = "${config.lib.stylix.colors.base03}";
      defaultFgColor = "${config.lib.stylix.colors.base05}";
    };
  };
}
