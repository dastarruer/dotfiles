{pkgs, ...}: {
  imports = [
    ./passfail2.nix
    ./recolor.nix
    ./syntax-highlighting.nix
    # ./auto-sync.nix
  ];

  # install addons that don't need configuration
  programs.anki.addons = with pkgs.ankiAddons; [
    review-heatmap
    anki-quizlet-importer-extended
    image-occlusion-enhanced
  ];
}
