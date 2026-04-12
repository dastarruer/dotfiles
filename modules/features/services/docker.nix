{...}: {
  flake.nixosModules.services_docker = {...}: {
    virtualisation.docker.enable = true;

    # Sudoless access to docker commands
    users.users.dastarruer.extraGroups = [
      "docker"
    ];
  };
}
