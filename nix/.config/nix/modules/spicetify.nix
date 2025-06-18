{
  pkgs,
  inputs,
  ...
}: {
  # Import spicetify module
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
  };
}
