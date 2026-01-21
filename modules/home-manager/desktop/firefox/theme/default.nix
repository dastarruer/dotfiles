{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file = {
    # Theme used: https://github.com/soulhotel/FF-ULTIMA
    ".mozilla/firefox/${config.home-manager.desktop.firefox.profile}/chrome" = {
      source = pkgs.fetchFromGitHub {
        owner = "soulhotel";
        repo = "FF-ULTIMA";
        rev = "4.3";
        sha256 = "sha256-Hz8LzwlRp72KYwpn77SZwr/wHI8yPHibSl+VKnQlQIo=";
      };
    };
  };

  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}".settings = {
    # Enable vertical tabs
    # "sidebar.verticalTabs" = true;

    # Color Schemes
    "user.theme.0.default" = true;
    "user.theme.transparent" = false;
    "user.theme.catppuccin" = false;
    "user.theme.catppuccin-frappe" = false;
    "user.theme.catppuccin-mocha" = false;
    "user.theme.gruvbox" = false;
    "user.theme.kanagawa-wave" = false;
    "user.theme.midnight" = false;
    "user.theme.midnight.animated.background" = false;
    "user.theme.scarlet" = false;
    "user.theme.fluent" = false;
    "user.theme.fluent.thinkpad" = false;
    "user.theme.brave" = false;
    "user.theme.ayu" = false;
    "user.theme.rose-pine" = false;

    # Nav Bar
    "ultima.navbar.autohide" = false;
    "ultima.navbar.float" = false;
    "ultima.navbar.float.fullsize" = false;
    "ultima.navbar.position" = "top";
    "ultima.navbar.hide.buttons" = true;
    "ultima.navbar.bookmarks.autohide" = true;
    "ultima.navbar.bookmarks.compact" = false;
    "ultima.navbar.bookmarks.position" = "center";
    "ultima.navbar.bookmarks.scrollable" = false;
    "ultima.navbar.bookmarks.float" = false;
    "ultima.navbar.bookmarks.hide.icons" = false;
    "ultima.navbar.windowcontrols.carl" = false;
    "ultima.navbar.windowcontrols.trafficlights" = false;
    "ultima.navbar.windowcontrols.whiteout" = false;
    "ultima.navbar.windowcontrols.fluent" = false;
    "ultima.navbar.theme.extensionspanel" = true;
    "ultima.disable.windowcontrols.button" = false;
    "ultima.navbar.update.ready.label" = false;
    "ultima.navbar.text.for.icons" = false;
    "ultima.navbar.bookmarks.tab.indicator" = false;
    "ultima.navbar.bookmarks.focus.blur" = false;

    # URL Bar
    "ultima.urlbar.animate.open" = true;
    "ultima.urlbar.animate.options" = false;
    "ultima.urlbar.hide.searchsuggestions" = false;
    "ultima.urlbar.centered" = true;
    "ultima.urlbar.hide.buttons" = false;
    "ultima.urlbar.transparent" = false;
    "ultima.urlbar.float" = false;
    "ultima.urlbar.drags.window" = false;
    "ultima.urlbar.scrollable" = false;
    "ultima.urlbar.focus.blur" = true;
    "ultima.urlbar.focus.blur.all" = false;
    "ultima.urlbar.focus.text.aligns.left" = false;
    "ultima.urlbar.hide.buttons.in.edge" = false;
    "ultima.urlbar.extension.label.fullwidth" = true;
    "ultima.urlbar.extension.label.hidden" = true;
    "ultima.urlbar.hide.trackingprotection.icon" = false;

    # Sidebar
    "ultima.sidebar.seperator" = false;
    "ultima.sidebar.hide.header" = true;
    "ultima.sidebar.revamped.hide.when.horizontal" = true;

    # Sidebery
    "ultima.sidebery.autohide" = true;
    "ultima.sidebery.expandon.inactive.windows" = false;
    "user.theme.xtension.sidebery" = true;

    # Findbar
    "ultima.findbar.position.top" = true;
    "ultima.findbar.disable.background.image" = false;

    # Tabs Related
    "ultima.spacing.compact.tabs" = true;
    "ultima.tabs.disable.update.dot" = true;
    "ultima.tabs.belowURLbar" = true;
    "ultima.tabs.hide.splitter" = false;
    "ultima.tabs.not.a.progress.bar" = true;
    "ultima.tabs.newtabbutton.ontop.1" = false;
    "ultima.tabs.newtabbutton.ontop.2" = false;
    "ultima.tabs.multiline.labels" = false;
    "ultima.tabs.closetabbutton.on.icon" = false;
    "ultima.tabs.pinned.always.visible" = false;
    "ultima.tabs.pinned.transparent.background" = false;
    "ultima.tabs.tabbar.autohide+compact" = false;
    "ultima.tabs.tabbar.autohide" = false;
    "ultima.tabs.tabbar.disabled" = false;
    "ultima.tabs.tabbar.hide.buttonstrip" = false;
    "ultima.tabs.tabgroups.label.1" = false;
    "ultima.tabs.tabgroups.label.2" = false;
    "ultima.tabs.tabgroups.label.3" = true;
    "ultima.tabs.tabgroups.label.tthornton" = false;
    "ultima.tabs.tabgroups.background.1" = false;
    "ultima.tabs.tabgroups.background.2" = true;
    "ultima.tabs.tabgroups.background.3" = false;
    "ultima.tabs.disable.scrollbar" = false;
    "ultima.tabs.horizontal.under.navbar" = true;
    "ultima.tabs.horizontal.fullwidth" = false;
    "ultima.tabs.focus.blur" = false;
    "ultima.tabs.tabCounter" = true;
    "ultima.tabs.splitview.tab.seperator" = false;
    "ultima.tabs.splitview.content.outline" = false;
    "ultima.tabs.splitview.focus.opacity" = false;
    "ultima.tabs.splitview.focus.shrink" = false;
    "ultima.tabs.splitview.gradient.background" = false;
    "ultima.tabs.tab.outline" = "";
    "ultima.tabs.tab.outline.color" = "";

    # Vertical Tabs Defaults
    "sidebar.revamp" = true;
    "sidebar.expandOnHover" = true;
    "sidebar.revamp.defaultLauncherVisible" = true;
    "sidebar.expandOnHoverMessage.dismissed" = false;
    "sidebar.visibility" = "expand-on-hover";
    "sidebar.revamp.round-content-area" = false;
    "sidebar.animation.expand-on-hover.duration-ms" = 140;
    "browser.tabs.tabMinWidth" = 0;

    # Context Menus
    "ultima.spacing.compact.menus" = false;
    "ultima.spacing.compact.contextmenu" = false;
    "ultima.spacing.relaxed.contextmenu" = false;
    "ultima.contextmenu.no.icons" = false;
    "ultima.contextmenu.no.navigation.icons" = false;
    "ultima.contextmenu.reduce.options" = false;
    "ultima.contextmenu.hide.separators" = false;

    # Alternate Styles
    "ultima.spacing.compact" = false;
    "ultima.spacing.relaxed" = false;
    "ultima.tabs.tabContainer.1" = false;
    "ultima.tabs.tabContainer.2" = false;
    "ultima.tabs.tabContainer.3" = true;
    "user.theme.xtension.newtab.rounded" = false;
    "user.theme.xtension.newtab.compact" = true;
    "ultima.xstyle.private" = false;
    "ultima.spacing.compact.addonmanager" = true;
    "ultima.privatebrowsing.gradient.border" = false;

    # Extra Theming
    "ultima.theme.icons" = true;
    "user.theme.xtension.ublock" = true;
    "user.theme.xtension.YT" = false;
    "user.theme.xtension.reddit" = false;
    "ultima.scrollbar.thin" = false;
    "user.theme.xtension.swap.addon.colors" = true;

    # Wallpapers
    "user.theme.wallpaper.catppuccin" = false;
    "user.theme.wallpaper.catppuccin-mocha" = false;
    "user.theme.wallpaper.catppuccin-frappe" = false;
    "user.theme.wallpaper.dusky" = false;
    "user.theme.wallpaper.fullmoon" = false;
    "user.theme.wallpaper.green" = false;
    "user.theme.wallpaper.gruvbox" = false;
    "user.theme.wallpaper.gruvbox.flowers" = false;
    "user.theme.wallpaper.gruvbox.light" = false;
    "user.theme.wallpaper.kanagawa-wave" = false;
    "user.theme.wallpaper.midnight" = false;
    "user.theme.wallpaper.midnight2" = false;
    "user.theme.wallpaper.fluent.dark" = false;
    "user.theme.wallpaper.fluent.light" = false;
    "user.theme.wallpaper.ayu" = false;
    "browser.newtabpage.activity-stream.newtabWallpapers.customWallpaper.enabled" = true;
    "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;

    # OS Specific / Extra Configs
    "ultima.enable.nightly.config" = false;
    "ultima.enable.js.config" = false;
    "widget.windows.mica" = true;
    "widget.windows.mica.extra" = true;
    "widget.windows.mica.popups" = 2;
    "widget.windows.mica.toplevel-backdrop" = 2;
    "widget.macos.titlebar-blend-mode.behind-window" = true;
    "browser.tabs.allow_transparent_browser" = false;

    # Required
    "ultima.xstyle.highlight.aboutconfig" = true;
    "browser.aboutConfig.showWarning" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "devtools.debugger.remote-enabled" = true;
    "devtools.chrome.enabled" = true;
    "devtools.debugger.prompt-connection" = false;
    "svg.context-properties.content.enabled" = true;
    "layout.css.has-selector.enabled" = true;
    "widget.gtk.ignore-bogus-leave-notify" = 1;
    "widget.gtk.rounded-bottom-corners.enabled" = true;
    "widget.gtk.native-context-menus" = false;

    # Recommended
    "browser.tabs.splitView.enabled" = true;
    "findbar.highlightAll" = true;
    "browser.tabs.insertAfterCurrent" = true;
    "browser.search.context.loadInBackground" = true;
    "browser.bookmarks.openInTabClosesMenu" = false;
    "full-screen-api.transition-duration.enter" = "0 0";
    "full-screen-api.transition-duration.leave" = "0 0";
    "full-screen-api.warning.timeout" = 0;
    "general.smoothScroll" = true;
    "general.smoothScroll.msdPhysics.enabled" = true;
  };
}
