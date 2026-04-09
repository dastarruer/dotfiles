{inputs, ...}: {
  flake.nixosModules.core = {
    config,
    lib,
    ...
  }: let
    ageKeyFile = "${config.home-manager.users.dastarruer.home.homeDirectory}/.config/sops/age/keys.txt";
    backup = config.custom.backup;
  in {
    sops = {
      # Path to secrets file
      defaultSopsFile = "${inputs.self.outPath}/secrets/secrets.yaml";
      defaultSopsFormat = "yaml";

      # Path to age key
      age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";
    };

    home-manager.users.dastarruer = {
      sops = {
        # Path to secrets file
        defaultSopsFile = "${inputs.self.outPath}/secrets/secrets.yaml";
        defaultSopsFormat = "yaml";

        # Path to age key
        age.keyFile = ageKeyFile;

        secrets = {
          ssh = {
            path = "${config.home-manager.users.dastarruer.home.homeDirectory}/.ssh/id_ed25519";
          };
          github_recovery_codes = {};
        };
      };

      # Symlink ssh key
      home.file.".ssh/id_ed25519.pub".source = "${inputs.self.outPath}/secrets/id_ed25519.pub";

      # Backup age key file
      custom.backup.backupPaths = lib.mkIf backup.enable [ageKeyFile];
    };
  };
}
