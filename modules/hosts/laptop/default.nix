{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.laptopConfiguration = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      laptopConfiguration
      laptopHardware
      laptopDisk
      laptopHome
    ];
  };
}
