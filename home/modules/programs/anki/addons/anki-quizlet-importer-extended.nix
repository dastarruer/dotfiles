{pkgs, ...}: {
  # this addon needs to be built manually
  programs.anki.addons = [
    (pkgs.anki-utils.buildAnkiAddon
      (finalAttrs: {
        pname = "image-occlusion-enhanced";
        # To find the version, run: git ls-remote --tags https://github.com/glutanimate/image-occlusion-enhanced.git
        version = "v1.4.0";
        src = pkgs.fetchFromGitHub {
          owner = " sviatoslav-lebediev";
          repo = "anki-quizlet-importer-extended";
          rev = finalAttrs.version;
          hash = "sha256-YR1hicBDb08J+1Qc+SDiJDXLo5FzLqCQGeVe7brbPME=";
        };
      }))
  ];
}
