{...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    browser = config.custom.desktop.browser.kind;
    profile = config.custom.desktop.browser.profile;
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        programs.zen-browser.profiles."${profile}".settings = {
          "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;
          "zen.welcome-screen.seen" = true;
        };
      };
    };
}
