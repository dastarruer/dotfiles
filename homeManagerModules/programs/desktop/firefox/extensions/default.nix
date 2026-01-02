{
  config,
  firefoxAddonPkgs,
  ...
}: {
  imports = [
    ./darkreader.nix
  ];

  programs.firefox.profiles."${config.dotfiles.desktop.firefox.profile}".extensions = {
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
}
