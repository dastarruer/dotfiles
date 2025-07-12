{
  pkgs,
  inputs,
  ...
}: {
  # Import the spicetify home manager module
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  # Spicetify themes
  programs.spicetify.theme = {
    name = "Gruvify";

    src = pkgs.fetchFromGitHub {
      owner = "Skaytacium";
      repo = "Gruvify";
      rev = "main";
      sha256 = "sha256-9KBA7ettPHjh7CH1QSuwbeLJCh2cdHXFghZeywVtRlI=";
    };
  };
}
