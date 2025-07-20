{
  pkgs,
  inputs,
  config,
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
    };
  };
}
# UNUSED
# programs.spicetify.theme = {
#   name = "Gruvify";
#   src = pkgs.fetchFromGitHub {
#     owner = "Skaytacium";
#     repo = "Gruvify";
#     rev = "main";
#     sha256 = "sha256-9kjoOd59c6/AUKQd0m+HVacrySZ+2JSGXK7Rb5IHH3o=";
#   };
# };

