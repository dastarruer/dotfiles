# script to quickly edit files in my dotfiles with fzf and nano
{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      fzfdf = prev.writeShellApplication {
        name = "fzfdf";
        runtimeInputs = with prev; [
          nano
          fzf
          findutils
        ];
        text = ''
          cd ~/.dotfiles

          file=$(find . -type f | fzf)

          if [ -n "$file" ]; then
              nano "$(realpath "$file")"  # Use the absolute path
          else
              echo "No file selected."
          fi
        '';
      };
    })
  ];

  home.packages = with pkgs; [
    fzfdf
  ];
}
