{inputs, ...}: {
  flake.nixosModules.core = {...}: {
    imports = [inputs.multiverse.nixosModules.default];
    multiverse.enable = true;
  };
}
