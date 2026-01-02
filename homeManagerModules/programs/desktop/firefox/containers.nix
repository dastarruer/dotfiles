{config, ...}: {
  programs.firefox.profiles."${config.dotfiles.desktop.firefox.profile}" = {
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
