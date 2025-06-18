{
  pkgs,
  inputs,
  ...
}: {
  # Import spicetify nix flake/module/whatever-the-hell
  # imports = [
  #   inputs.spicetify-nix.nixosModules.default
  # ];

  # Get the cli
  environment.systemPackages = with pkgs; [
    spicetify-cli
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
  };
}
