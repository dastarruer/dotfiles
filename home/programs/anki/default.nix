# Check here for packaging an anki addon: https://github.com/NixOS/nixpkgs/blob/master/pkgs/games/anki/with-addons.nix
{
  config,
  pkgs,
  ...
}: let
  theme = import ./addons/recolor.nix {inherit config;};
  passfailConfig = import ./addons/passfail2.nix {inherit config;};
in {
  home.packages = with pkgs; [
    (anki.withAddons (with ankiAddons; [
      (passfail2.withConfig {
        config = passfailConfig;
      })
      (recolor.withConfig {
        config = theme;
      })

      review-heatmap

      # Image occlusion enhanced
      (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
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
      }))
    ]))
  ];
}
