{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = let
      name = "screenshot";
    in [
      ",Print, exec, ${pkgs.writeShellApplication {
        name = "${name}";
        runtimeInputs = with pkgs; [
          rofi
          grimblast
          tesseract
          wl-clipboard
          libnotify
        ];
        text = ''
          # Define the main options for Rofi
          main_options="region screenshot\nfull screenshot\nocr"

          # Display main options in Rofi and capture the selection
          main_choice=$(echo -e "$main_options" | rofi -dmenu -p "Screenshot:")

          # Handle the main choice
          case "$main_choice" in
              "region screenshot")
                  echo "Selected: Region Screenshot"
                  sleep 0.3
                  grimblast copysave area -n
                  ;;

              "full screenshot")
                  sleep 0.3
                  grimblast copysave screen -n
                  ;;
              "ocr")
                  sleep 0.3
                  grimblast save area - | tesseract stdin stdout | wl-copy
                  notify-send "Clipboard:" "$(wl-paste)"
                  ;;
              *)
                  echo "No valid option selected."
                  ;;
          esac
        '';
      }}/bin/${name}"
    ];
  };
}
