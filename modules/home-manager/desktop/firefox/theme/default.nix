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
  };

  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}" = {
    # Adding the userjs this way lets me overwrite specific settings in the settings option
    preConfig = themeUserJs;

    settings = {
      # TAB SETTINGS: https://ff-ultima.github.io/docs/settings/tab-settings
      "ultima.tabs.tabbar.autohide" = true;
      "ultima.tabs.tabbar.autohide+compact" = true;
      "ultima.spacing.compact.tabs" = true;
      "ultima.tabs.disable.scrollbar" = true;
      "ultima.tabs.multiline.labels" = true;
      "ultima.tabs.not.a.progress.bar" = true;
      "ultima.tabs.pinned.transparent.background" = true;
      "ultima.xstyle.containertabs.i" = true;

      # URL BAR SETTINGS: https://ff-ultima.github.io/docs/settings/urlbar-settings
      "ultima.urlbar.focus.autogrow" = true;
      "ultima.urlbar.focus.text.aligns.left" = true;
      "ultima.urlbar.hide.buttons" = true;

      # CONTENT AREA SETTINGS: https://ff-ultima.github.io/docs/settings/content-area-settings
      "ultima.spacing.compact.addonmanager" = true;
      "ultima.spacing.compact" = true;
      "ultima.findbar.position.top" = true;
    };
  };
}
