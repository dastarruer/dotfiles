{...}: {
  flake.nixosModules.desktop_localsend = {...}: {
    # Unable to open firewall port in home manager, so it is here instead
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
