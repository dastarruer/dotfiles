{pkgs, ...}: {
  imports = [
    ./image-occlusion-enhanced.nix
    ./passfail2.nix
    ./recolor.nix
    ./anki-quizlet-importer-extended.nix
    # ./auto-sync.nix
  ];

  # install addons that don't need configuration
  programs.anki.addons = with pkgs.ankiAddons; [
    review-heatmap
  ];
}
