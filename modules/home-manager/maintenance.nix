# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{
  config,
  pkgs,
  ...
}: {
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "Sat 12:00";
    useFlake = true;
    # inputs.self.outDir will throw an error when used with useFlake for whatever reason.
    flakeDir = "${config.home.homeDirectory}/.dotfiles";
  };

  systemd.user.services.push-flake = {
    Unit = {
      Description = "Push home-manager flake changes to remote repository";

      After = ["home-manager-auto-upgrade.service"];
      Requires = ["home-manager-auto-upgrade.service"];
    };

    Service = {
      ExecStart = let
        name = "push_flake";
      in "${pkgs.writeShellApplication {
        name = name;

        runtimeInputs = with pkgs; [
          git
        ];

        text = ''
          cd "${config.home.homeDirectory}/.dotfiles"
          git add .
          git commit -m "update flake" || exit 0
          git push
        '';
      }}/bin/${name}";

      Restart = "on-failure";
      RestartSec = 30;
      Type = "oneshot";
    };
  };

  # Clean nix store and remove old home-manager generations
  programs.nh.clean = {
    enable = true;
    dates = "03:00";
    extraArgs = "--keep 7 --keep-since 15d";
  };
}
