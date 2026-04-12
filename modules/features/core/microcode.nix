{inputs, ...}: {
  flake.nixosModules.core = {...}: {
    imports = [inputs.ucodenix.nixosModules.default];

    # Microcode updates (might as well yk)
    services.ucodenix = {
      enable = true;
      cpuModelId = "auto";
    };

    # https://github.com/e-tho/ucodenix#3-apply-changes
    boot.kernelParams = ["microcode.amd_sha_check=off"];
  };
}
