{...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    profile = config.custom.desktop.browser.profile;
    browser = config.custom.desktop.browser.kind;
  in
    lib.mkIf (browser == "firefox") {
      home-manager.users.dastarruer = {
        programs.firefox.profiles."${profile}".bookmarks = {
          force = true;
          settings = [
            {
              name = "NixOS Search - Packages";
              url = "https://search.nixos.org/packages";
              keyword = "nix";
            }

            # school
            {
              name = "AP Calculus BC";
              url = "https://ispsedu.schoology.com/course/8479041569/materials";
              keyword = "math";
            }
            {
              name = "AP Calculus BC (AP Classroom)";
              url = "https://apclassroom.collegeboard.org/26/assignments/dashboard";
              keyword = "ap-math";
            }
            {
              name = "AP Physics 1";
              url = "https://ispsedu.schoology.com/course/8479041580/materials";
              keyword = "physics";
            }
            {
              name = "AP Physics 1 (AP Classroom)";
              url = "https://apclassroom.collegeboard.org/92/assignments/dashboard";
              keyword = "ap-physics";
            }
            {
              name = "AP Literature";
              url = "https://ispsedu.schoology.com/course/8479041577/materials";
              keyword = "english";
            }
            {
              name = "AP Literature (AP Classroom)";
              url = "https://apclassroom.collegeboard.org/13/assignments/dashboard";
              keyword = "ap-english";
            }
            {
              name = "Advanced Music";
              url = "https://ispsedu.schoology.com/course/8506163291/materials";
              keyword = "music";
            }
            {
              name = "Contemporary Issues";
              url = "https://ispsedu.schoology.com/course/8479041593/materials";
              keyword = "ins";
            }
            {
              name = "Gmail";
              url = "https://mail.google.com/mail/u/1/#inbox";
              keyword = "gmail";
            }
          ];
        };
      };
    };
}
