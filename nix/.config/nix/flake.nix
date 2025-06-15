{
  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: {
    nixosConfigurations = {
      dastarruer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Pass inputs to your config
          ({...}: {
            _module.args.inputs = {inherit nixpkgs;};
          })
          ./configuration.nix
        ];
      };
    };
  };
}
