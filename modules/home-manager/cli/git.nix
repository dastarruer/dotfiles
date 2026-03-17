{
  config,
  lib,
  ...
}: let
  fish = config.home-manager.cli.shell.fish;
in {
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
      lfs.enable = true;

      # yh i... don't know either why this is necessary...
      settings = lib.mkMerge [
        {
          # Prefer ssh urls instead of https ones
          url."git@github.com:" = {
            insteadOf = "https://github.com/";
          };
          # Use vscode for commit messages
          core.editor = "${lib.getExe config.programs.vscode.package} --wait";
          # Automatically push to the current branch
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
        }
        (lib.mkIf (builtins.pathExists usernamePath) {
          user.name = lib.removeSuffix "\n" (builtins.readFile usernamePath);
        })
        (lib.mkIf (builtins.pathExists emailPath) {
          user.email = lib.removeSuffix "\n" (builtins.readFile emailPath);
        })
      ];
    };

    programs.fish.shellAliases = lib.mkIf fish.enable {
      ga = "git add";
      gb = "git branch";
      "g." = "git add . && git status";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gch = "git checkout";
    };
  };
}
