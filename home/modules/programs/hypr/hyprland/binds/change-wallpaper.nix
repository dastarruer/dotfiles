{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER+SHIFT, W, exec, ${pkgs.writeShellApplication {
        name = "change_wallpaper";
        runtimeInputs = with pkgs; [
          swww
          libnotify
        ];
        text = ''
          # File to track the last selected wallpaper
          INDEX_FILE="$HOME/.cache/.current_wallpaper_index"

          CURRENT_INDEX=$(cat "$INDEX_FILE")

          # Directory containing wallpapers
          WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

          # Get the list of wallpapers in sorted order
          mapfile -d ''\'' WALLPAPERS < <(find "$WALLPAPER_DIR" -type f -print0 | sort -z)

          # Total number of wallpapers
          NUM_WALLPAPERS=''\${#WALLPAPERS[@]}

          # Calculate the next index
          NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WALLPAPERS ))

          # Set the new wallpaper
          swww img "''\${WALLPAPERS[$NEXT_INDEX]}" -t wipe --transition-angle 30 --transition-duration 1

          # Symlink the wallpaper so it can be accessed by other programs
          ln -sf "''\${WALLPAPERS["$NEXT_INDEX"]}" "$HOME"/Pictures/wallpaper

          # Update the index file
          echo "$NEXT_INDEX" > "$INDEX_FILE"

          # Notify user
          notify-send -t 1000 "Wallpaper set to: $(basename "''\${WALLPAPERS[$NEXT_INDEX]}")"
        '';
      }}/bin/change_wallpaper"
    ];
  };
}
