{inputs, ...}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  # Declare a bunch of extensinos
  programs.firefox.profiles.${firefoxProfile}.extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
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
}
