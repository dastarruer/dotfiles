{...}: {
  flake.nixosModules.core = {...}: {
    # extra ram basically
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
    };

    # Set swappiness to a value higher than 100 to ensure zram is actually used
    boot.kernel.sysctl."vm.swappiness" = 150;
  };
}
