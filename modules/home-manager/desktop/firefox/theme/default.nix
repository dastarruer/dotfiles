{
  config,
  pkgs,
  ...
}: let
  # 1. Fetch the base theme
  themeRepo = pkgs.fetchFromGitHub {
    owner = "soulhotel";
    repo = "FF-ULTIMA";
    rev = "4.3";
    sha256 = "sha256-Hz8LzwlRp72KYwpn77SZwr/wHI8yPHibSl+VKnQlQIo=";
  };

  # 2. Define the Stylix-powered CSS
  # This uses YourName as the folder/theme name to match FF-ULTIMA defaults
  customCssText = ''
    @media (prefers-color-scheme: dark) { :root {
        --uc-browser-color:      #${config.lib.stylix.colors.base00};
        --uc-text:               #${config.lib.stylix.colors.base05};
        --uc-layered-background: #${config.lib.stylix.colors.base01};
        --uc-navbar-background:  var(--toolbar-bgcolor);
        --uc-urlbar-background:  #${config.lib.stylix.colors.base01};
        --uc-findbar-background: var(--uc-layered-background);
        --uc-sidebar-background: var(--uc-layered-background);
        --uc-tabsbar-background: var(--uc-browser-color);
        --uc-tab-background:     transparent;
        --uc-tab-selected:       #${config.lib.stylix.colors.base02};
        --uc-tab-selected-text:  #${config.lib.stylix.colors.base0B};
        --uc-button-selected:    #${config.lib.stylix.colors.base02};
        --uc-button-red:         #${config.lib.stylix.colors.base08};
        --uc-context-menu:       #${config.lib.stylix.colors.base01};
        --uc-panel-background:   var(--uc-layered-background);
        --uc-panel-border:       #${config.lib.stylix.colors.base00};
        --uc-panel-border-2:     #${config.lib.stylix.colors.base02};

        /* Accents mapped to Base16 standard slots */
        --uc-accent-color-1:     #${config.lib.stylix.colors.base0E}; /* Purple/Accent 1 */
        --uc-accent-color-2:     #${config.lib.stylix.colors.base0D}; /* Blue/Accent 2 */
        --uc-accent-color-3:     #${config.lib.stylix.colors.base04}; /* Muted Text */
        --uc-accent-color-4:     #${config.lib.stylix.colors.base01}; /* Dark Layer */
        --uc-accent-color-5:     #${config.lib.stylix.colors.base0B}; /* Green/Success */
        --uc-accent-color-6:     #${config.lib.stylix.colors.base08}; /* Red/Error */
        --uc-accent-color-7:     #${config.lib.stylix.colors.base02}; /* Surface */

        --uc-transparent:        rgba(0,0,0,0);
        --uc-box-shadow:         0.15rem 0.3rem 0.3rem -0.1rem rgba(0,0,0,0.4);
        --uc-box-shadow-panel:   0.15rem 0.3rem 0.3rem -0.1rem rgba(0,0,0,0.5);
        --uc-button-border-radius: 0px;
    }}

    / * I cant be bothered to change these. Who uses light mode anyways? * /
    @media (prefers-color-scheme: light) { :root {
        --uc-browser-color:      rgb(161, 158, 176);
        --uc-text:               rgb(35, 35, 35);
        --uc-layered-background: rgb(172, 168, 191);
        --uc-navbar-background:  var(--toolbar-bgcolor);
        --uc-urlbar-background:  rgb(139, 142, 163);
        --uc-findbar-background: var(--uc-layered-background);
        --uc-sidebar-background: rgb(153, 152, 173);
        --uc-tabsbar-background: var(--uc-browser-color);
        --uc-tab-background:     transparent;
        --uc-tab-selected:       var(--uc-urlbar-background);
        --uc-tab-selected-text:  var(--uc-accent-color-5);
        --uc-button-selected:    rgb(116, 113, 133);
        --uc-button-red:         #f54e4e;
        --uc-context-menu:       var(--uc-layered-background);
        --uc-panel-background:   var(--uc-layered-background);
        --uc-panel-border:       rgba(125, 125, 125, 0.4);
        --uc-panel-border-2:     rgba(125, 125, 125, 0.3);
        --uc-accent-color-1:     rgb(70, 63, 77);
        --uc-accent-color-2:     #fcfc88;
        --uc-accent-color-3:     rgb(186, 194, 222);
        --uc-accent-color-4:     rgb(24, 24, 37);
        --uc-accent-color-5:     #19083d;
        --uc-accent-color-6:     #5f3787;
        --uc-accent-color-7:     rgb(44, 55, 80);
        --uc-transparent:        rgba(0,0,0,0);
        --uc-box-shadow: 0.1rem 0.4rem 0.4rem -0.1rem rgba(75,75,75,0.3);
        --uc-box-shadow-panel: 0.1rem 0.3rem 0.4rem -0.1rem rgba(65,65,65,0.3);
        --uc-button-border-radius: 0px;
    }}


    /* Detailed customization - Overwriting existing variables. Everything below applies the custom variables to elements of the Browser, with some adjustments. */

    #main-window:not([lwtheme]) {
        --toolbar-bgcolor: var(--uc-browser-color) !important;
        --inactive-titlebar-opacity: 1 !important;
        --toolbar-bgcolor: var(--uc-browser-color) !important;
        --lwt-accent-color-inactive: var(--lwt-accent-color) !important;
        --uc-tabs-lwt: color-mix(in srgb, var(--lwt-accent-color) 75%, #000);
        --uc-sb-lwt: color-mix(in srgb, var(--lwt-accent-color) 75%, #000);
        --toolbox-non-lwt-bgcolor-inactive: ActiveCaption !important;
        --toolbox-non-lwt-textcolor-inactive: CaptionText !important;
        --tab-selected-bgcolor: var(--uc-tab-selected) !important;
        --tab-loading-fill: var(--uc-accent-color-1) !important;
        --tab-selected-textcolor: var(--uc-text) !important;
        --tab-hover-background-color: var(--uc-tab-selected) !important;
        --button-background-color-ghost-hover: var(--uc-button-selected) !important;
        --button-background-color: var(--uc-button-selected) !important;
        --button-background-color-hover: var(--uc-button-selected) !important;
        --button-background-color-active: var(--uc-button-selected) !important;
        --button-hover-bgcolor: var(--uc-button-selected) !important;
        --toolbarbutton-hover-background: var(--uc-button-selected) !important;
        --button-active-bgcolor: var(--uc-button-selected) !important;
        --toolbarbutton-active-background: var(--uc-button-selected) !important;
        --button-primary-bgcolor: var(--uc-accent-color-1) !important;
        --button-primary-hover-bgcolor: var(--uc-accent-color-1) !important;
        --buttons-destructive-hover-bgcolor: #9d1c1c;  /*red*/
        --buttons-destructive-active-bgcolor: var(--uc-button-red); /*red*/
        --toolbarbutton-icon-fill: var(--uc-accent-color-1) !important; /*toolbar button color*/
        --toolbar-field-background-color: var(--uc-accent-color-4) !important;
        --toolbar-field-border-color: var(--uc-accent-color-3) !important;
        --toolbar-field-focus-border-color: var(--uc-accent-color-5) !important;
        --urlbarView-result-button-selected-color: var(--uc-text) !important;
        --urlbarView-result-button-selected-background-color: var(--uc-button-selected) !important;
        --urlbarView-highlight-background: var(--uc-button-selected) !important;
        --urlbarView-hover-background: var(--uc-button-selected) !important;
        --urlbar-box-hover-bgcolor: var(--uc-button-selected) !important;
        --urlbar-box-hover-text-color: var(--uc-text) !important;
        --urlbar-icon-border-radius: var(--uc-button-border-radius) !important;
        --arrowpanel-menuitem-border-radius: var(--uc-button-border-radius) !important;
        --arrowpanel-border-radius: var(--uc-all-border-radius);
        --toolbarbutton-border-radius: var(--uc-button-border-radius) !important;
        --arrowpanel-menuitem-border-radius: var(--uc-button-border-radius) !important;
        --menuitem-border-radius: var(--uc-button-border-radius) !important;
        --button-border-radius: var(--uc-button-border-radius) !important;
        --toolbarbutton-border-radius: var(--uc-button-border-radius) !important;
        --toolbar-field-color: var(--uc-text) !important;
        --toolbar-field-focus-color: var(--uc-text) !important;
        --toolbar-color: var(--uc-text) !important;
        --toolbar-field-color: var(--uc-text) !important;
        --toolbar-field-focus-color: var(--uc-text) !important;
        --sidebar-text-color: var(--uc-text) !important;
        --arrowpanel-background: var(--uc-panel-background) !important;
        --arrowpanel-border-color: var(---uc-panel-border-ii) !important;
        --arrowpanel-color: var(--uc-text) !important;
        --newtab-background-color: var(--uc-tabsbar-background) !important;
        --panel-background: var(--uc-panel-background) !important;
        --panel-item-hover-bgcolor: var(--uc-button-selected) !important;
        --panel-banner-item-hover-bgcolor: var(--uc-button-selected) !important;
        --short-notification-background: var(--uc-accent-color-2) !important;
        --panel-border-color: var(--uc-panel-border) !important;
        --organizer-toolbar-background: var(--uc-accent-color-4) !important;
        --organizer-pane-background: var(--uc-accent-color-4) !important;
        --organizer-content-background: var(--uc-accent-color-4) !important;
        --organizer-hover-background: var(--uc-accent-color-4) !important;
        --organizer-selected-background: var(--uc-button-selected) !important;
        --organizer-focus-selected-color: var(--uc-button-selected) !important;
        --organizer-outline-color: rgb(0,221,255) !important;
        --organizer-toolbar-field-background: var(--uc-accent-color-4) !important;
        --organizer-toolbar-field-background-focused: var(--uc-accent-color-1) !important;
        --content-select-background-image: none !important;
    }

    /* Applying variables  further to create the Theme --------------------------------*/

    /* Main window adjustments ----------------------------------------*/


    /* URL Bar ----------------------------------------*/

    #main-window:not([lwtheme]) {
        & .urlbar {
            color: var(--uc-accent-color-1) !important;
        }
        & .urlbarView-row {
            color: var(--uc-accent-color-1) !important;
            &[selected] {
                color: var(--uc-accent-color-5) !important;
            }
        }
        & .urlbarView-row:hover {
            color: var(--uc-accent-color-2) !important;
        }
        & #urlbar[focused]:not([suppress-focus-border]) > #urlbar-background,
        & #urlbar[focused]:not([suppress-focus-border]) > .urlbar-background {
            outline-color: color-mix(in srgb, var(--uc-accent-color-5) 85%, transparent)  !important;
            outline-offset: -1px !important;
        }
    }

    /* Find bar -------------------------------------------------------*/


    /* Sidebars -------------------------------------------------------*/


    /* Tabs -----------------------------------------------------------*/

    #main-window:not([lwtheme]) {
        /* tabs - selected tabs */
        & .tab-label-container[selected] {
            color: var(--uc-tab-selected-text) !important;
        }
        & .tab-background[multiselected] {
            outline-color: var(--uc-accent-color-3) !important;
            outline-offset: 1px !important;
        }
        & .tab-background[multiselected] {
            @media (prefers-color-scheme: light) {
                outline-color: var(--uc-accent-color-1) !important;
                outline-offset: none !important;
            }
        }
        /* tabs - pinned tabs */
        & .tab-label-container[pinned] {
            color: var(--uc-accent-color-6) !important;
        }
        & #vertical-pinned-tabs-splitter {
            border-top: 1px var(--uc-accent-color-2) dashed !important;
            min-height: 3px !important;
            &:hover{background: var(--uc-accent-color-2) !important;}
        }
        /*tabs - all other tabs */
        & .tab-label-container:not([selected=""],[pinned]) {
            color: var(--uc-text) !important;
        }
    }

    /* Button Adjustments ---------------------------------------------*/

    #main-window:not([lwtheme]) {
        & .toolbarbutton-text {
            color: var(--toolbarbutton-icon-fill);
        }
        & #nav-bar .toolbarbutton-1,
        &  #nav-bar .toolbarbutton-text {
            color: var(--uc-accent-color-2) !important;
        }
    }

    /* Popups/Menus ---------------------------------------------------*/


    /* Context Menu ---------------------------------------------------*/

    #main-window:not([lwtheme]) {
        menupopup:not(#ContentSelectDropdownPopup), panel:not(.autoscroller) {
            --panel-background: var(--uc-context-menu) !important;
            --panel-border-radius: var(--uc-button-border-radius) !important;
            --panel-border-color: var(--uc-panel-border-2) !important;
            --panel-color: var(--uc-text) !important;
            --panel-shadow: none !important;
        }
        menuitem:hover {
            background-color: var(--uc-button-selected) !important;
            color: var(--uc-accent-color-5) !important;
            border-radius: 7px !important;
        }
        menu:where([_moz-menuactive="true"]:not([disabled="true"])),
        menuitem:where([_moz-menuactive="true"]:not([disabled="true"])){
            background-color: var(--uc-button-selected) !important;
            color: var(--uc-accent-color-5) !important;
            border-radius: 7px !important;
        }
    }
  '';

  # 3. Create a single derivation that combines the repo + your CSS
  # This fixes the "outside $HOME" error by doing the work in the Nix store
  combinedTheme = pkgs.runCommand "ff-ultima-custom-colors" {} ''
    mkdir -p $out
    cp -r ${themeRepo}/* $out/
    chmod -R +w $out
    mkdir -p $out/theme/color-schemes/YourName
    echo "${customCssText}" > $out/theme/color-schemes/YourName/ffu-colorscheme.css
  '';

  themeUserJs = builtins.readFile "${themeRepo}/user.js";
in {
  stylix.targets.firefox.enable = false;

  home.file = {
    # Linking the entire combined directory to the chrome folder
    ".mozilla/firefox/${config.home-manager.desktop.firefox.profile}/chrome" = {
      source = combinedTheme;
    };
  };

  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}" = {
    preConfig = themeUserJs;

    settings = {
      # Wallpaper
      "user.theme.wallpaper.fluent.dark" = true;

      # Colorscheme settings
      "user.theme.0.default" = false;
      "user.theme.YourTheme" = true;

      # TAB SETTINGS
      "ultima.tabs.tabbar.autohide" = true;
      "ultima.spacing.compact.tabs" = true;
      "ultima.tabs.disable.scrollbar" = true;
      "ultima.tabs.multiline.labels" = true;
      "ultima.tabs.not.a.progress.bar" = true;
      "ultima.tabs.pinned.transparent.background" = true;
      "ultima.xstyle.containertabs.i" = true;

      # URL BAR SETTINGS
      "ultima.urlbar.focus.autogrow" = true;
      "ultima.urlbar.focus.text.aligns.left" = true;
      "ultima.urlbar.hide.buttons" = true;

      # CONTENT AREA SETTINGS
      "ultima.spacing.compact.addonmanager" = true;
      "ultima.spacing.compact" = true;
      "ultima.findbar.position.top" = true;
    };
  };
}
