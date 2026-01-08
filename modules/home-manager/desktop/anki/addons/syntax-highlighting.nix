{pkgs, ...}: {
  # this addon needs to be built manually
  programs.anki.addons = [
    (pkgs.anki-utils.buildAnkiAddon
      (finalAttrs: {
        pname = "syntax-highlighting";
        # To find the version, run: git ls-remote --tags https://github.com/cav71/syntax-highlighting-ng.git
        version = "0.0.7";
        src = pkgs.fetchFromGitHub {
          owner = "cav71";
          repo = "syntax-highlighting-ng";
          rev = finalAttrs.version;
          # Only get files from src/syntax_highlighting_ng folder in the repo
          sparseCheckout = ["src/syntax_highlighting_ng"];
          hash = "sha256-kNZBNf1O6CDYMilvfITCM0pC4OZSP0/rKReBnRYwUUw=";
        };
        # Treat that src folder as the root
        sourceRoot = "${finalAttrs.src.name}/src/syntax_highlighting_ng";
        patchFlags = ["-p3"];
        patches = [./0001-Change-language.patch];
      }))
  ];
}
