{...}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  programs.firefox.profiles.${firefoxProfile} = {
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
}
