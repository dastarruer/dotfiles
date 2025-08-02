{...}: {
  programs.git = {
    enable = true;

    userName = "Ayush Pramanik";
    userEmail = "ayushpramanik399@gmail.com";

    # Config
    extraConfig = {
      # Use vs codium for commit messages
      core.editor = "codium --wait";

      # Automatically push to the current branch or something
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
