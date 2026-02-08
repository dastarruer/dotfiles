{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.cli.git.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable git functionality.";
    };
  };

  config = lib.mkIf config.home-manager.cli.git.enable {
    sops.secrets = {
      name = {};
      email = {};
    };

    programs.git = let
      usernamePath = config.sops.secrets.name.path;
      emailPath = config.sops.secrets.email.path;
    in {
      enable = true;

      settings = {
        name = lib.mkIf (builtins.pathExists usernamePath) builtins.readFile usernamePath;
        email = lib.mkIf (builtins.pathExists emailPath) builtins.readFile emailPath;

        # Prefer ssh urls instead of https ones
        url."git@github.com:" = {
          insteadOf = "https://github.com/";
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
