{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      commit-dotfiles = prev.writeShellApplication {
        name = "commit-dotfiles";

        runtimeInputs = with prev; [
          gitMinimal
          alejandra
          coreutils
          openssh
        ];

        text = ''
          dotfiles="$HOME/.dotfiles"
          nix="$dotfiles"

          cd "$dotfiles"

          # Use ''\${1:-} to safely check the variable in Nix/Bash strict mode
          if [ -z "''\${1:-}" ]; then
            COMMIT_MESSAGE="stuff"
          else
            COMMIT_MESSAGE="$1"
          fi

          # Lint all nix files
          alejandra "$nix"

          git add .
          git commit -m "$COMMIT_MESSAGE"
          git push & disown
        '';
      };
    })
  ];

  home.packages = with pkgs; [
    commit-dotfiles
  ];
}
