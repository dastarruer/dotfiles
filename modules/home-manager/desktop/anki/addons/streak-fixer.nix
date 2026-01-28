# TODO: Unfinished
{pkgs, ...}: {
  programs.anki.addons = [
    (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
      pname = "anki-streak-fixer";
      # Using the latest commit hash for reproducibility
      version = "v0.4.2";

      src = pkgs.fetchFromGitHub {
        owner = "NSBum";
        repo = "AnkiStreakFixer";
        rev = finalAttrs.version;
        hash = "sha256-vmBzyqwpKnb4qnPplYQft8qWHLayl5/N2GgAKdWT/7o=";
      };
    }))
  ];
}
