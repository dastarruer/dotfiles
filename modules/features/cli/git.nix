{...}: {
  flake.nixosModules.cli_git = {
    config,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;

    usernamePath = hmConfig.sops.secrets.name.path;
    emailPath = hmConfig.sops.secrets.email.path;
  in {
    home-manager.users.dastarruer = {
      sops.secrets = {
        name = {};
        email = {};
      };

      programs.gh = {
        enable = true;
      };

      programs.git = let
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

            # Automatically push to the current branch
            push.autoSetupRemote = true;
          }
          (lib.mkIf (builtins.pathExists usernamePath) {
            user.name = lib.removeSuffix "\n" (builtins.readFile usernamePath);
          })
          (lib.mkIf (builtins.pathExists emailPath) {
            user.email = lib.removeSuffix "\n" (builtins.readFile emailPath);
          })
        ];
      };

      programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
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
  };
}
