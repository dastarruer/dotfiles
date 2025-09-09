{
  config,
  inputs,
  ...
}: let
  userName = builtins.readFile config.sops.secrets.name.path;
  userEmail = builtins.readFile config.sops.secrets.email.path;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Get the encrypted username and email
  sops.secrets = {
    name = {};
    email = {};
  };

  programs.git = {
    enable = true;

    userName = userName;
    userEmail = userEmail;

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
