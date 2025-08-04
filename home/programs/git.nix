{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Get the encrypted username and email
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";

    secrets = {
      git_username = {};
      git_email = {};
    };
  };

  programs.git = {
    enable = true;

    userName = "${config.sops.secrets.git_username.path}";
    userEmail = "${config.sops.secrets.git_email.path}";

    # Config
    extraConfig = {
      # Use vs codium for commit messages
      core.editor = "codium --wait";

      # Automatically push to the current branch or something
      push.autoSetupRemote = true;

      credential."https://github.com" = {
        helper = [
          "" # Clears any inherited helpers
          "!/run/current-system/sw/bin/gh auth git-credential"
        ];
      };

      credential."https://gist.github.com" = {
        helper = [
          ""
          "!/run/current-system/sw/bin/gh auth git-credential"
        ];
      };
    };

    # Paths to be ignored globally
    ignores = [
      "*.vscode/"
      "*.venv/"
      "*target/"
    ];
  };
}
