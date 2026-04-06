{inputs, ...}: {
  flake.nixosModules.desktop_firefox = {config, ...}: {
    home-manager.users.dastarruer = let
      # Get the betterfox userjs as a base for my settings
      betterfoxUserjs = builtins.readFile "${inputs.betterfox}/user.js";
    in {
      # Declare settings and overrides, most of which I've stolen from here:
      # https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
      programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}" = {
        preConfig = betterfoxUserjs;

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
          # Improves youtube video playback (https://www.reddit.com/r/firefox/comments/pe07q5/firefox_youtube_performance_on_linux/)
          "media.hardware-video-decoding.force-enabled" = true;

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

          # Auto-enable extensions
          "extensions.autoDisableScopes" = 0;

          # Disable alt menu
          "ui.key.menuAccessKeyFocuses" = false;

          # Disable middle click paste
          "middlemouse.paste" = false;

          # Disable the warning when accessing about:config
          "browser.aboutConfig.showWarning" = false;

          # Configure toolbar (https://www.reddit.com/r/NixOS/comments/1s8dmkr/configuring_firefox_menubar_and_toolbar/)
          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [];
              unified-extensions-area = [
                "simple-tab-groups_drive4ik-browser-action"
                "sponsorblocker_ajay_app-browser-action"
                "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
                "_6a65273e-2b26-40f5-b66e-8eed317307da_-browser-action"
                "addon_darkreader_org-browser-action"
                "jid1-kkzogwgsw3ao4q_jetpack-browser-action"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                "firefoxcolor_mozilla_com-browser-action"
                "_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action"
              ];
              nav-bar = [
                "sidebar-button"
                "back-button"
                "forward-button"
                "stop-reload-button"
                "customizableui-special-spring1"
                "vertical-spacer"
                "urlbar-container"
                "customizableui-special-spring2"
                "downloads-button"
                "reset-pbm-toolbar-button"
                "ublock0_raymondhill_net-browser-action"
                "unified-extensions-button"
                "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
              ];
              toolbar-menubar = ["menubar-items"];
              TabsToolbar = [];
              vertical-tabs = ["tabbrowser-tabs"];
              PersonalToolbar = ["personal-bookmarks"];
            };
            seen = [
              "reset-pbm-toolbar-button"
              "addon_darkreader_org-browser-action"
              "jid1-kkzogwgsw3ao4q_jetpack-browser-action"
              "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
              "simple-tab-groups_drive4ik-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "sponsorblocker_ajay_app-browser-action"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "developer-button"
              "screenshot-button"
              "firefoxcolor_mozilla_com-browser-action"
              "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
              "_6a65273e-2b26-40f5-b66e-8eed317307da_-browser-action"
              "_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action"
            ];
            dirtyAreaCache = [
              "unified-extensions-area"
              "nav-bar"
              "vertical-tabs"
              "toolbar-menubar"
              "TabsToolbar"
              "PersonalToolbar"
            ];
            currentVersion = 23;
            newElementCount = 2;
          };

          # STEAM DECK SETTINGS
          # Steam Deck specific fixes (e.g., touch improvements, hardware accel)
          # "dom.w3c_touch_events.enabled" = lib.mkIf cfg.enable 1;

          # # Helps with touch/trackpad detection
          # "ui.primary_pointer_capabilities" = lib.mkIf cfg.enable 115;

          # # Hardware acceleration
          # "media.ffmpeg.vaapi.enabled" = lib.mkIf cfg.enable true;

          # # Saves vertical space on small screen
          # "browser.tabs.drawInTitlebar" = lib.mkIf cfg.enable true;

          # Do not restore previous session on startup
          # "browser.sessionstore.resume_session_once" = lib.mkIf cfg.enable false;
        };
      };
    };
  };
}
