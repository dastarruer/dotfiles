{...}: {
  flake.nixosModules.core = {...}: {
    # extra ram basically
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
    };
  };
}
