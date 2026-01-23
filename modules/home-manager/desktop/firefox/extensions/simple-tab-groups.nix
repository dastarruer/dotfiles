{
  config,
  lib,
  firefoxAddonPkgs,
  ...
}: let
  profile = config.home-manager.desktop.firefox.profile;
  containers = config.programs.firefox.profiles."${profile}".containers;

  # Helper to get container IDs from profile config
  getContainerId = name: "firefox-container-${toString config.programs.firefox.profiles."${profile}".containers."${name}".id}";

  # thank you chatgpt
  mkGroups = groupList:
    lib.imap1 (index: group: {
      id = index;
      title = group.name;
      newTabContainer = getContainerId group.container;

      # Required settings, otherwise extension will crash
      isArchive = false;
      discardTabsAfterHide = false;
      discardExcludeAudioTabs = false;
      prependTitleToWindow = false;
      exportToBookmarksWhenAutoBackup = false;
      leaveBookmarksOfClosedTabs = false;
      ifDifferentContainerReOpen = false;
      excludeContainersForReOpen = [];
      isSticky = false;
      catchTabContainers = [];
      catchTabRules = "";
      moveToGroupIfNoneCatchTabRules = null;
      muteTabsWhenGroupCloseAndRestoreWhenOpen = false;
      showTabAfterMovingItIntoThisGroup = false;
      showOnlyActiveTabAfterMovingItIntoThisGroup = false;
      showNotificationAfterMovingTabIntoThisGroup = false;
      bookmarkId = null;
    })
    groupList;
in {
  programs.firefox.profiles."${profile}".extensions = {
    packages = with firefoxAddonPkgs; [
      simple-tab-groups
    ];

    settings."simple-tab-groups@drive4ik" = {
      force = true;
      settings = {
        version = "5.3.2";
        containers = {
          "firefox-container-${getContainerId "personal"}" = {
            name = containers.personal.name;
            color = containers.personal.color;
            icon = containers.personal.icon;
          };
          "firefox-container-${getContainerId "school"}" = {
            name = containers.school.name;
            color = containers.school.color;
            icon = containers.school.icon;
          };
        };

        groups = mkGroups [
          {
            name = "other";
            container = "personal";
          }
          {
            name = "nix";
            container = "personal";
          }
          {
            name = "math";
            container = "school";
          }
          {
            name = "english";
            container = "school";
          }
          {
            name = "chem";
            container = "school";
          }
          {
            name = "spanish";
            container = "school";
          }
          {
            name = "physics";
            container = "school";
          }
          {
            name = "personal project";
            container = "school";
          }
          {
            name = "design";
            container = "school";
          }
          {
            name = "comp sci";
            container = "school";
          }
        ];
      };
    };
  };
}
