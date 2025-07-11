{
  firefox-profile,
  inputs,
  ...
}: {
  # Declare a bunch of extensinos
  profiles.${firefox-profile} = {
    extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
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
