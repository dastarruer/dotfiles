{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.laptopConfiguration = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopConfiguration
    ];
  };
}
