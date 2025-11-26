{pkgs, ...}: {
  # this addon needs to be built manually
  programs.anki.addons = [
    (pkgs.anki-utils.buildAnkiAddon
      (finalAttrs: {
        pname = "anki-contanki";
        # To find the version, run: git ls-remote --tags https://github.com/roxgib/anki-contanki.git
        version = "v1.0";
        src = pkgs.fetchFromGitHub {
          owner = "roxgib";
          repo = "anki-contanki";
          rev = finalAttrs.version;
          hash = "sha256-a8EbCQVuxJv04RVtiGUz5ypRdqFUIqK8Uqz5Zf0XkqI=";
        };
      }))
  ];
}
