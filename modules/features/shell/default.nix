{self, ...}: {
  flake.nixosModules.shell = {...}: {
    imports = with self.nixosModules; [
      shell_fish
      shell_starship
      shell_fastfetch
    ];
  };
}
