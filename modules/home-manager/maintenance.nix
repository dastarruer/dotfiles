# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{config, ...}: {
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "Sat 12:00";
    useFlake = true;
    # inputs.self.outDir will throw an error when used with useFlake for whatever reason.
    flakeDir = "${config.home.homeDirectory}/.dotfiles";
  };


  };

  # Clean nix store and remove old home-manager generations
  programs.nh.clean = {
    enable = true;
    dates = "03:00";
    extraArgs = "--keep 7 --keep-since 15d";
  };
}
