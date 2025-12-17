{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      commit-dotfiles = prev.writeShellApplication {
        name = "commit-dotfiles";
        runtimeInputs = with prev; [
          gitMinimal
          alejandra
        ];
        text = ''
          dotfiles="$HOME/.dotfiles"
          nix="$dotfiles"

          cd "$dotfiles"

          # Get commit message
          if [ -z "$1" ]; then
            COMMIT_MESSAGE="stuff"
          else
            COMMIT_MESSAGE="$1"
          fi

          # If the flake has been updated, pull the file
          git pull

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
