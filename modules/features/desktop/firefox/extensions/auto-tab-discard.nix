{inputs, ...}: {
  flake.nixosModules.desktop_firefox = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.dastarruer = {
      programs.firefox.profiles."${config.custom.desktop.firefox.profile}".extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.system}; [
          auto-tab-discard
        ];

        settings."{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = {
          force = true;

          settings = {
            "chrome.storage.local" = {
              "last-update" = 1773106333037;
              "idle" = false;
              "idle-timeout" = 300;
              "period" = 600;
              "number" = 6;
              "max.single.discard" = 50;
              "trash.period" = 24;
              "trash.unloaded" = false;
              "mode" = "time-based";
              "click" = "click.popup";
              "audio" = true;
              "paused" = false;
              "pinned" = false;
              "form" = true;
              "battery" = false;
              "online" = false;
              "notification.permission" = false;
              "page.context" = false;
              "tab.context" = true;
              "link.context" = true;
              "log" = false;
              "faqs" = true;
              "favicon" = false;
              "prepends" = "💤";
              "go-hidden" = false;
              "simultaneous-jobs" = 10;
              "favicon-delay" = 500;
              "whitelist" = [];
              "whitelist-url" = [];
              "force.hostnames" = [];
              "memory-enabled" = false;
              "memory-value" = 60;
              "startup-unpinned" = false;
              "startup-pinned" = false;
              "startup-release-pinned" = false;
              "./plugins/dummy/core.js" = false;
              "./plugins/blank/core.js" = true;
              "./plugins/focus/core.js" = false;
              "./plugins/trash/core.js" = false;
              "trash.whitelist-url" = [];
              "./plugins/force/core.js" = false;
              "./plugins/next/core.js" = false;
              "./plugins/previous/core.js" = false;
              "./plugins/new/core.js" = false;
              "./plugins/unloaded/core.js" = false;
              "./plugins/youtube/core.js" = true;
            };
            "localStorage" = {
              "click" = "popup";
            };
          };
        };
      };
    };
  };
}
