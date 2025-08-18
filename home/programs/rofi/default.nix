{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./plugins
  ];

  programs.rofi = {
    enable = true;

    # Specify rofi-wayland because wayland
    package = pkgs.rofi-wayland;
  };

  # Symlink the rofi config
  # Do this manually because apparently symlinking a directory is too hard for home manager...
  # Rofi config comes from here: https://github.com/Spelljinxer/dotfiles/blob/main/.config/rofi/
  home.activation.linkRofi = lib.hm.dag.entryAfter ["writeBoundary"] ''
    SRC="$HOME/.dotfiles/config/rofi"
    DEST="$HOME/.config/rofi"

    # Remove existing symlink or directory
    if [ -e "$DEST" ]; then
        rm -rf "$DEST"
    fi

    # Create symlink
    ln -s "$SRC" "$DEST"
  '';
}
