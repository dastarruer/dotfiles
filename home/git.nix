{...}: {
  programs.git = {
    enable = true;

    userName = "Ayush Pramanik";
    userEmail = "ayushpramanik399@gmail.com";

    # Config
    extraConfig = {
      push.autoSetupRemote = true;

      credential."https://github.com" = {
        helper = [
          "" # Clears any inherited helpers
          "!/run/current-system/sw/bin/gh auth git-credential"
        ];
      };

      credential."https://gist.github.com" = {
        helper = [
          ""
          "!/run/current-system/sw/bin/gh auth git-credential"
        ];
      };
    };

    # Paths to be ignored globally
    ignores = [
      "*.vscode/"
      "*.venv/"
      "*target/"
    ];
  };
}
