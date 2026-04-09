{
  flake.nixosModules.services_ssh = _: {
    services.openssh = {
      enable = true;
    };
  };
}
