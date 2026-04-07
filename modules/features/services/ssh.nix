{
  flake.modules.nixos.services_ssh = _: {
    services.openssh = {
      enable = true;
    };
  };
}
