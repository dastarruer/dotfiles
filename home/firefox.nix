# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{inputs, ...}: let
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

    profiles.${firefox-profile} = {
      # Declare a bunch of extensinos
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        sponsorblock
        darkreader
        pywalfox
        simple-tab-groups
        auto-tab-discard
        startpage-private-search
        i-dont-care-about-cookies
        privacy-badger
        to-deepl
        link-cleaner
      ];

      # Declare a bunch of settings which I've stolen from here (https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix)
      settings = {
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;

        # disable updates (pretty pointless with nix)
        "app.update.channel" = "default";

        "browser.contentblocking.category" = "strict";
        "browser.ctrlTab.recentlyUsedOrder" = false;

        "browser.download.viewableInternally.typeWasRegistered.svg" = true;
        "browser.download.viewableInternally.typeWasRegistered.webp" = true;
        "browser.download.viewableInternally.typeWasRegistered.xml" = true;

        "browser.link.open_newwindow" = true;

        "browser.search.region" = "PL";
        "browser.search.widget.inNavBar" = true;

        "browser.shell.checkDefaultBrowser" = false;
        "browser.tabs.loadInBackground" = true;

        # disable all the annoying quick actions
        "browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.suggest.quickactions" = false;

        "distribution.searchplugins.defaultLocale" = "en-US";

        "doh-rollout.balrog-migration-done" = true;
        "doh-rollout.doneFirstRun" = true;

        "dom.forms.autocomplete.formautofill" = false;

        "general.autoScroll" = true;
        "general.useragent.locale" = "en-US";

        "extensions.update.enabled" = false;
        "extensions.webcompat.enable_picture_in_picture_overrides" = true;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat.perform_injections" = true;
        "extensions.webcompat.perform_ua_overrides" = true;

        "print.print_footerleft" = "";
        "print.print_footerright" = "";
        "print.print_headerleft" = "";
        "print.print_headerright" = "";

        "privacy.donottrackheader.enabled" = true;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
