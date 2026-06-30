{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    pkgs,
    lib,
    ...
  }: let
    browser = config.custom.desktop.browser.kind;
  in
    lib.mkIf (browser == "firefox") {
      home-manager.users.dastarruer = {
        programs.firefox.profiles."${config.custom.desktop.browser.profile}".extensions = {
          # Necessary to configure extension settings through hm
          force = true;

          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.system}; [
            ublock-origin
            i-dont-care-about-cookies
            privacy-badger
            link-cleaner
            bitwarden
          ];
        };
      };
    };
}
