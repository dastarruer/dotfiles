{inputs, ...}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  programs.firefox.profiles.${firefoxProfile}.extensions = {
    # Required for stylix
    force = true;

    # Declare a bunch of extensinos
    packages = with inputs.firefox-addons.packages."x86_64-linux"; [
      ublock-origin
      sponsorblock
      darkreader
      pywalfox
      simple-tab-groups
      startpage-private-search
      i-dont-care-about-cookies
      privacy-badger
      link-cleaner
      bitwarden
    ];
  };
}
