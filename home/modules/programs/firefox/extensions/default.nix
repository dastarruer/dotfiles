{
  inputs,
  pkgs,
  ...
}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  imports = [
    ./darkreader.nix
  ];

  programs.firefox.profiles.${firefoxProfile}.extensions = {
    # Required for stylix
    force = true;

    # Declare a bunch of extensions
    packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
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
