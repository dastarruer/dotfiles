{config, ...}: {
  sops = {
    # Path to secrets file
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Path to age key
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      ssh = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      github_recovery_codes = {};
    };
  };

  # Symlink ssh key
  home.file.".ssh/id_ed25519.pub".source = ../secrets/id_ed25519.pub;
}
