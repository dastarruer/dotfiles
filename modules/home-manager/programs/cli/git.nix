{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.cli.git.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable git functionality.";
    };
  };

  config = lib.mkIf config.home-manager.cli.git.enable {
    sops.secrets = {
      name = {};
      email = {};
    };

    programs.git = {
      enable = true;

      settings = {
        user = let
          userName = builtins.readFile config.sops.secrets.name.path;
          userEmail = builtins.readFile config.sops.secrets.email.path;
        in {
          name = userName;
          email = userEmail;
        };

        # Use vscode for commit messages
        core.editor = "${lib.getExe config.programs.vscode.package} --wait";

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
  };
}
