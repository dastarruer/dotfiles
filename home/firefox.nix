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
    ".mozilla/firefox/${firefox-profile}/user.js".text = betterfoxUserjs;
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
        startpage-private-search
        i-dont-care-about-cookies
        privacy-badger
        link-cleaner
        bitwarden
      ];

      # Set up containers
      containersForce = true;
      containers = {
        personal = {
          name = "personal";
          color = "turquoise";
          icon = "pet";
          id = 1;
        };
        school = {
          name = "school";
          color = "orange";
          icon = "dollar";
          id = 2;
        };
      };

      # Declare a bunch of settings which I've stolen from here (https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix)
      settings = {
        # USER JS OVERRIDES
        "sidebar.revamp" = false;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;

        # OTHER
        # Disable remote experimentation and telemetry
        "app.normandy.first_run" = false; # Don't run Normandy experiments on first run
        "app.shield.optoutstudies.enabled" = false; # Disable Shield studies (user experiments)

        # Disable Firefox updates — not needed since Nix handles them
        "app.update.channel" = "default"; # No updates via Firefox itself

        # Use strict tracking protection
        "browser.contentblocking.category" = "strict"; # Stronger anti-tracking measures

        # Change tab-switching behavior
        "browser.ctrlTab.recentlyUsedOrder" = false; # Use tab bar order instead of recently used

        # Allow internal viewing of these formats without downloading
        "browser.download.viewableInternally.typeWasRegistered.svg" = true;
        "browser.download.viewableInternally.typeWasRegistered.webp" = true;
        "browser.download.viewableInternally.typeWasRegistered.xml" = true;

        # Open links in new windows (true means open in new window instead of tab)
        "browser.link.open_newwindow" = true;

        # Set default search region and display style
        "browser.search.widget.inNavBar" = true; # Show search box in toolbar

        # Don't ask to make Firefox default
        "browser.shell.checkDefaultBrowser" = false;

        # Load new tabs in background (instead of switching to them immediately)
        "browser.tabs.loadInBackground" = false;

        # Disable quick actions in address bar (e.g., “open settings” shortcut)
        "browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.suggest.quickactions" = false;

        # Set default language for search plugins and UI
        "distribution.searchplugins.defaultLocale" = "en-US";
        "general.useragent.locale" = "en-US";

        # Prevent DoH setup prompts
        "doh-rollout.balrog-migration-done" = true;
        "doh-rollout.doneFirstRun" = true;

        # Disable form autofill suggestions (for privacy)
        "dom.forms.autocomplete.formautofill" = false;

        # Enable middle-click scrolling
        "general.autoScroll" = true;

        # Disable automatic extension updates
        "extensions.update.enabled" = false;

        # Enable Picture-in-Picture (PIP) support and related compatibility tweaks
        "extensions.webcompat.enable_picture_in_picture_overrides" = true;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat.perform_injections" = true;
        "extensions.webcompat.perform_ua_overrides" = true;

        # Clean up print headers and footers
        "print.print_footerleft" = "";
        "print.print_footerright" = "";
        "print.print_headerleft" = "";
        "print.print_headerright" = "";

        # Enable Do Not Track header
        "privacy.donottrackheader.enabled" = true;

        # Allow userChrome.css and userContent.css to work
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };

  # Tell stylix to style this profile
  stylix.targets.firefox.profileNames = ["${firefox-profile}"];
}
