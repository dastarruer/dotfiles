{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    pkgs,
    lib,
    ...
  }: let
    profile = config.custom.desktop.browser.profile;
    browser = config.custom.desktop.browser.kind;
    firefoxPkgs = inputs.firefox-addons.packages.${pkgs.stdenv.system};
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        programs.zen-browser.profiles."${profile}".extensions.          packages = with firefoxPkgs; [
          ublock-origin
          bitwarden
        ];
      };
    };
}
