{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";

    # Ssh key
    secrets = {
      ssh = {
        owner = config.users.users.dastarruer.name;
        group = config.users.users.dastarruer.group;
        path = "/home/dastarruer/.ssh/id_ed25519";
        mode = "0600"; # Only owner can read/write
      };

      github_recovery_codes = {};
    };
  };
}
