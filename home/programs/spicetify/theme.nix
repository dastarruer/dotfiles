{pkgs, ...}: {
  # Spicetify themes
  programs.spicetify.theme = {
    name = "Gruvify";

    src = pkgs.fetchFromGitHub {
      owner = "Skaytacium";
      repo = "Gruvify";
      rev = "main";
      sha256 = "sha256-9kjoOd59c6/AUKQd0m+HVacrySZ+2JSGXK7Rb5IHH3o=";
    };
  };
}
