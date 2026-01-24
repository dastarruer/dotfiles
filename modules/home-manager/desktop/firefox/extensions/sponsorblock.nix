{
  config,
  firefoxAddonPkgs,
  ...
}: {
  sops.secrets.sponsorblock_userid = {};

  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}".extensions = {
    packages = with firefoxAddonPkgs; [
      darkreader
    ];

    settings."addon@darkreader.org" = {
      force = true;

      settings = {
        sponsorTimesContributed = 32;
        chapterCategoryAdded = true;
        autoSkipOnMusicVideosUpdate = true;
        invidiousInstances = [
          "www.youtubekids.com"
          "anontube.lvkaszus.pl"
          "inv.citw.lgbt"
          "inv.in.projectsegfau.lt"
          "inv.tux.pizza"
          "inv.zzls.xyz"
          "invidious.asir.dev"
          "invidious.drgns.space"
          "invidious.fdn.fr"
          "invidious.flokinet.to"
          "invidious.io.lol"
          "invidious.lunar.icu"
          "invidious.nerdvpn.de"
          "invidious.no-logs.com"
          "invidious.perennialte.ch"
          "invidious.privacydev.net"
          "invidious.private.coffee"
          "invidious.projectsegfau.lt"
          "invidious.protokolla.fi"
          "invidious.slipfox.xyz"
          "iv.datura.network"
          "iv.ggtyler.dev"
          "iv.melmac.space"
          "iv.nboeck.de"
          "onion.tube"
          "vid.priv.au"
          "vid.puffyan.us"
          "yewtu.be"
          "yt.artemislena.eu"
          "yt.cdaut.de"
          "yt.drgnz.club"
          "yt.oelrichsgarcia.de"
          "invidious.snopyta.org"
        ];
        userID = "${builtins.readFile config.sops.secrets.sponsorblock_userid.path}";
        categoryPillUpdate = true;
        showZoomToFillError2 = false;
        forceChannelCheck = true;
        changeChapterColor = true;
        dontShowNotice = true;
        showDeArrowPromotion = false;
        showPopupDonationCount = 5;
        barTypes = {
          "preview-chooseACategory" = {
            color = "#${config.lib.stylix.colors.base07}";
            opacity = "0.7";
          };
          sponsor = {
            color = "#${config.lib.stylix.colors.base0B}";
            opacity = "0.7";
          };
          "preview-sponsor" = {
            color = "#${config.lib.stylix.colors.base0B}";
            opacity = "0.7";
          };
          selfpromo = {
            color = "#${config.lib.stylix.colors.base0A}";
            opacity = "0.7";
          };
          "preview-selfpromo" = {
            color = "#${config.lib.stylix.colors.base0A}";
            opacity = "0.7";
          };
          exclusive_access = {
            color = "#${config.lib.stylix.colors.base0B}";
            opacity = "0.7";
          };
          interaction = {
            color = "#${config.lib.stylix.colors.base0E}";
            opacity = "0.7";
          };
          "preview-interaction" = {
            color = "#${config.lib.stylix.colors.base0E}";
            opacity = "0.7";
          };
          intro = {
            color = "#${config.lib.stylix.colors.base0C}";
            opacity = "0.7";
          };
          "preview-intro" = {
            color = "#${config.lib.stylix.colors.base0C}";
            opacity = "0.7";
          };
          outro = {
            color = "#${config.lib.stylix.colors.base0D}";
            opacity = "0.7";
          };
          "preview-outro" = {
            color = "#${config.lib.stylix.colors.base0D}";
            opacity = "0.7";
          };
          preview = {
            color = "#${config.lib.stylix.colors.base0D}";
            opacity = "0.7";
          };
          "preview-preview" = {
            color = "#${config.lib.stylix.colors.base0D}";
            opacity = "0.7";
          };
          music_offtopic = {
            color = "#${config.lib.stylix.colors.base0A}";
            opacity = "0.7";
          };
          "preview-music_offtopic" = {
            color = "#${config.lib.stylix.colors.base04}";
            opacity = "0.7";
          };
          poi_highlight = {
            color = "#${config.lib.stylix.colors.base0F}";
            opacity = "0.7";
          };
          "preview-poi_highlight" = {
            color = "#${config.lib.stylix.colors.base0E}";
            opacity = "0.7";
          };
          filler = {
            color = "#${config.lib.stylix.colors.base0E}";
            opacity = "0.9";
          };
          "preview-filler" = {
            color = "#${config.lib.stylix.colors.base0E}";
            opacity = "0.7";
          };
          chapter = {
            color = "#${config.lib.stylix.colors.base02}";
            opacity = "0";
          };
          hook = {
            color = "#${config.lib.stylix.colors.base0D}";
            opacity = "0.8";
          };
          "preview-hook" = {
            color = "#${config.lib.stylix.colors.base0D}";
            opacity = "0.7";
          };
        };
        categorySelections = [
          {
            name = "sponsor";
            option = 2;
          }
          {
            name = "poi_highlight";
            option = 1;
          }
          {
            name = "exclusive_access";
            option = 0;
          }
          {
            name = "chapter";
            option = 0;
          }
          {
            name = "selfpromo";
            option = 2;
          }
          {
            name = "interaction";
            option = 2;
          }
          {
            name = "intro";
            option = 2;
          }
          {
            name = "outro";
            option = 2;
          }
          {
            name = "preview";
            option = 2;
          }
          {
            name = "music_offtopic";
            option = 0;
          }
        ];
        isVip = false;
        skipCount = 1059;
        submissionCountSinceCategories = 32;
        minutesSaved = 599.2623816833329;
        permissions = {
          sponsor = true;
          selfpromo = true;
          exclusive_access = true;
          interaction = true;
          intro = true;
          outro = true;
          preview = true;
          hook = true;
          music_offtopic = true;
          filler = true;
          poi_highlight = true;
          chapter = true;
        };
        defaultCategory = "chooseACategory";
        segmentListDefaultTab = 0;
        renderSegmentsAsChapters = false;
        showTimeWithSkips = true;
        disableSkipping = false;
        muteSegments = true;
        fullVideoSegments = true;
        fullVideoLabelsOnThumbnails = true;
        manualSkipOnFullVideo = false;
        trackViewCount = true;
        trackViewCountInPrivate = true;
        trackDownvotes = true;
        trackDownvotesInPrivate = false;
        showUpcomingNotice = false;
        noticeVisibilityMode = 3;
        hideVideoPlayerControls = false;
        hideInfoButtonPlayerControls = false;
        hideDeleteButtonPlayerControls = false;
        hideUploadButtonPlayerControls = false;
        hideSkipButtonPlayerControls = false;
        hideDiscordLaunches = 0;
        hideDiscordLink = false;
        supportInvidious = false;
        serverAddress = "https://sponsor.ajay.app";
        minDuration = 0;
        skipNoticeDuration = 4;
        audioNotificationOnSkip = false;
        checkForUnlistedVideos = false;
        testingServer = false;
        ytInfoPermissionGranted = false;
        allowExpirements = true;
        showDonationLink = true;
        showUpsells = true;
        showNewFeaturePopups = true;
        donateClicked = 0;
        autoHideInfoButton = true;
        autoSkipOnMusicVideos = false;
        skipNonMusicOnlyOnYoutubeMusic = false;
        scrollToEditTimeUpdate = false;
        hookUpdate = false;
        showChapterInfoMessage = true;
        darkMode = true;
        showCategoryGuidelines = true;
        showCategoryWithoutPermission = false;
        showSegmentNameInChapterBar = true;
        showAutogeneratedChapters = true;
        useVirtualTime = true;
        showSegmentFailedToFetchWarning = true;
        allowScrollingToEdit = true;
        deArrowInstalled = false;
        showDeArrowInSettings = true;
        shownDeArrowPromotion = false;
        cleanPopup = false;
        hideSegmentCreationInPopup = false;
        prideTheme = false;
        categoryPillColors = {};
        skipKeybind = {key = "Enter";};
        skipToHighlightKeybind = {
          key = "Enter";
          ctrl = true;
        };
        startSponsorKeybind = {key = ";";};
        submitKeybind = {key = "'";};
        actuallySubmitKeybind = {
          key = "'";
          ctrl = true;
        };
        previewKeybind = {
          key = ";";
          ctrl = true;
        };
        nextChapterKeybind = {
          key = "ArrowRight";
          ctrl = true;
        };
        previousChapterKeybind = {
          key = "ArrowLeft";
          ctrl = true;
        };
        closeSkipNoticeKeybind = {key = "Backspace";};
        downvoteKeybind = {
          key = "h";
          shift = true;
        };
        upvoteKeybind = {
          key = "g";
          shift = true;
        };
        payments = {
          licenseKey = null;
          lastCheck = 0;
          lastFreeCheck = 0;
          freeAccess = false;
          chaptersAllowed = false;
        };
        colorPalette = {
          red = "#${config.lib.stylix.colors.base08}";
          white = "#${config.lib.stylix.colors.base07}";
          locked = "#${config.lib.stylix.colors.base0A}";
        };
      };
    };
  };
}
