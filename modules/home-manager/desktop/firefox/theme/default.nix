{
  config,
  pkgs,
  ...
}: let
  # Theme used: https://github.com/soulhotel/FF-ULTIMA
  theme = pkgs.fetchFromGitHub {
    owner = "soulhotel";
    repo = "FF-ULTIMA";
    rev = "4.3";
    sha256 = "sha256-Hz8LzwlRp72KYwpn77SZwr/wHI8yPHibSl+VKnQlQIo=";
  };

  # The theme has a bunch of custom settings
  themeUserJs = builtins.readFile "${theme}/user.js";
in {
  # Disable stylix color theming for firefox since we're using a custom theme
  stylix.targets.firefox.enable = false;

  home.file = {
    ".mozilla/firefox/${config.home-manager.desktop.firefox.profile}/chrome" = {
      source = theme;
    };

    ".mozilla/firefox/${config.home-manager.desktop.firefox.profile}/user.js".text = themeUserJs;
  };
}
