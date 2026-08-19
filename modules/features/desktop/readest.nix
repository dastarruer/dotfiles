{inputs, ...}: {
  flake.nixosModules.desktop_readest = {pkgs, ...}: {
    nix.settings = {
      substituters = ["https://readest.cachix.org"];
      trusted-public-keys = [
        "readest.cachix.org-1:KvKAePcZZCZB8ytFIAOGdgN3VRdmFHGRMHqMVckbt5c="
      ];
    };

    home-manager.users.dastarruer = {
      home.packages = [
        inputs.readest.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
