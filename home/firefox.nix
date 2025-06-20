{...}: let
  # Firefox theme that I will use
  firefox-theme = "https://github.com/cascadefox/cascade";

  # Folder under which all firefox stuff goes
  firefox-profile = "default";

  # Basically I'm taking the betterfox user js here
  betterfoxGit = builtins.fetchGit {
    url = "https://github.com/yokoffing/Betterfox";
    rev = "82553f016744f0eb0528f8d92c3eb30ef9a1f6c4";
  };

  betterfoxUserjs = builtins.readFile "${betterfoxGit}/user.js";

  # And then I'm adding these overrides to the user js
  myOverrides = ''
    // OVERRIDES
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    user_pref("sidebar.revamp", false);
    user_pref("svg.context-properties.content.enabled", true);
    user_pref("layout.css.has-selector.enabled", true);
    user_pref("browser.urlbar.suggest.calculator", true);
    user_pref("browser.urlbar.unitConversion.enabled", true);
    user_pref("browser.urlbar.trimHttps", true);
    user_pref("browser.urlbar.trimURLs", true);
    user_pref("widget.gtk.rounded-bottom-corners.enabled", true);
    user_pref("widget.gtk.ignore-bogus-leave-notify", 1);
  '';

  mergedUserJs = "${betterfoxUserjs}\n${myOverrides}";
in {
  home.file = {
    # Fetch firefox theme (https://www.reddit.com/r/NixOS/comments/1f5wbjd/installing_a_complex_user_css_for_firefox/)
    ".mozilla/firefox/${firefox-profile}/chrome" = {
      source = "${builtins.fetchGit {
        url = firefox-theme;
        rev = "f8c6bb5a36f24aba61995204ff5497c865e78e50";
      }}/chrome";
      recursive = true;
    };

    # Symlink user js
    ".mozilla/firefox/${firefox-profile}/user.js".text = mergedUserJs;
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
    };
  };
}
