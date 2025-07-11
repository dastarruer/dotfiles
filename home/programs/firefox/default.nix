# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{...}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  programs.firefox = {
    enable = true;
  };

  # Tell stylix to style this profile
  stylix.targets.firefox.profileNames = ["${firefoxProfile}"];
}
