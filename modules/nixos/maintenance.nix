{...}: {
  # Remove unused generations
  programs.nh = {
    enable = true; # Needs to be enabled; otherwise cleaning service won't work

    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  systemd.timers.nh-clean.timerConfig.RandomizedDelaySec = "1h";

  # Auto optimize store
  # Instead of enabling the option in nix.settings, which would slow down rebuilds, just optimize the store periodically
  nix.optimise.automatic = true;

  nix.settings = {
    # Do not install duplicate files on rebuilds
    # Because of this, probably not
    # auto-optimise-store = true;

    # GC if free space falls below 10GB, stop when 20GB is free
    min-free = 5 * 1024 * 1024 * 1024;
    max-free = 10 * 1024 * 1024 * 1024;
  };
}
