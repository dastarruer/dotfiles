{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    awww = config.services.awww;
    theme = config.custom.theme.name;
    wallpaperDir = "${inputs.self.outPath}/config/wallpapers/${theme}";
    dunst = config.services.dunst;
  in {
    nixpkgs.overlays = [
      (final: prev: {
        change-wallpaper = prev.writeShellApplication {
          name = "change-wallpaper";

          runtimeInputs = with prev; [
            libnotify
            findutils
            coreutils
          ];

          text = ''
            WALLPAPER_DIR=${wallpaperDir}

            # File to track the last selected wallpaper
            INDEX_FILE="$HOME/.cache/.current_wallpaper_index"

            # Ensure cache directory exists and the index file defaults to 0 if missing/invalid
            mkdir -p "$(dirname "$INDEX_FILE")"
            if ! [ -s "$INDEX_FILE" ] || ! grep -Eq '^[0-9]+$' "$INDEX_FILE"; then
              echo 0 > "$INDEX_FILE"
            fi

            CURRENT_INDEX=$(cat "$INDEX_FILE")

            # Get the list of wallpapers in sorted order
            mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f | sort)

            # Total number of wallpapers
            NUM_WALLPAPERS=''\${#WALLPAPERS[@]}

            # Calculate the next index
            NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WALLPAPERS ))
            SELECTED_WALLPAPER=''${WALLPAPERS[$NEXT_INDEX]}

            # Set the new wallpaper
            ${lib.optionalString awww.enable ''
              ${pkgs.awww}/bin/awww img "$SELECTED_WALLPAPER" -t wipe --transition-angle 30 --transition-duration 1
            ''}

            # Symlink the wallpaper so it can be accessed by other programs
            ln -sf "''\${WALLPAPERS["$NEXT_INDEX"]}" "$HOME"/Pictures/wallpaper

            # Update the index file
            echo "$NEXT_INDEX" > "$INDEX_FILE"

            # Notify user
            notify-send -t 1000 "Wallpaper set to: $(basename "$SELECTED_WALLPAPER")"
          '';
        };
      })
    ];

    custom.wm.dunst.excludeSummaries = lib.mkIf dunst.enable ["Wallpaper set to:"];
  };
}
