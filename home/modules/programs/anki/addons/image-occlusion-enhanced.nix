{pkgs, ...}: {
  image-occlusion-enhanced = pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
    pname = "image-occlusion-enhanced";
    # To find the version, run: git ls-remote --tags https://github.com/glutanimate/image-occlusion-enhanced.git
    version = "v1.4.0";
    src = pkgs.fetchFromGitHub {
      owner = "glutanimate";
      repo = "image-occlusion-enhanced";
      rev = finalAttrs.version;
      sparseCheckout = ["src/image_occlusion_enhanced"];
      hash = "sha256-YR1hicBDb08J+1Qc+SDiJDXLo5FzLqCQGeVe7brbPME=";
    };
    sourceRoot = "${finalAttrs.src.name}/src/image_occlusion_enhanced";
  });
}
