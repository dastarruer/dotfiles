{
  config,
  firefoxAddonPkgs,
  ...
}: {
  imports = [
    ./darkreader.nix
  ];

  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}" = {
    settings = {
      # Auto-enable extensions
      "extensions.autoDisableScopes" = 0;
    };

    extensions = {
      # Required for stylix
      force = true;

      # Declare a bunch of extensions
      packages = with firefoxAddonPkgs; [
        ublock-origin
        sponsorblock
        simple-tab-groups
        i-dont-care-about-cookies
        privacy-badger
        link-cleaner
        bitwarden
      ];
    };
  };
}
