{ self, inputs, ... }: {
  flake.nixosConfigurations.laptopConfiguration = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopConfiguration
      self.nixosModules.laptopHardware
      self.nixosModules.laptopDisk
      self.homeConfigurations.laptopHome
    ];
  };
}
