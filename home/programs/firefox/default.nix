# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{inputs, ...}: let
  # Folder under which all firefox stuff goes
  firefox-profile = "default";
in {
  programs.firefox = {
    enable = true;

    profiles.${firefox-profile} = {
      # Set up containers
      containersForce = true;
      containers = {
        personal = {
          name = "personal";
          color = "turquoise";
          icon = "pet";
          id = 1;
        };
        school = {
          name = "school";
          color = "orange";
          icon = "dollar";
          id = 2;
        };
      };
    };
  };

  # Tell stylix to style this profile
  stylix.targets.firefox.profileNames = ["${firefox-profile}"];
}
