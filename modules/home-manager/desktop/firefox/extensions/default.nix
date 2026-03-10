{
  config,
  firefoxAddonPkgs,
  ...
}: {
  imports = [
    ./darkreader.nix
    ./simple-tab-groups.nix
    ./sponsorblock.nix
    ./auto-tab-discard.nix
  ];

  programs.firefox = {
    # Allow all extensions to be used in incognito
    policies.ExtensionSettings."*" = {
      installation_mode = "allowed";
      allowed_types = ["extension"];
      private_browsing = true;
    };

    profiles."${config.home-manager.desktop.firefox.profile}" = {
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
          i-dont-care-about-cookies
          privacy-badger
          link-cleaner
          bitwarden
        ];
      };
    };
  };
}
