#!/usr/bin/env bash

# CONFIG
SAVE_DIR=$(xdg-user-dir PICTURES)
# END CONFIG

# LANGUAGE STRINGS
lang_scr_whole="📷 Screenshot of whole screen (all monitors)"
lang_scr_fragment="📷 Screenshot of selected region"
lang_scr_window="📷 Screenshot of selected Window"
lang_scr_output="📷 Screenshot of current monitor"

lang_delay="⏰ Delay:"
lang_nodelay="🕰 No delay"

lang_save_png="🖼️ Save as png"
lang_save_jpg="🖼️ Save as jpg"
lang_copy_clipboard="🖼️ Copy to clipboard"

lang_copied="Screenshot copied to clipboard"
lang_saved="Screenshot saved to file"
# END OF LANGUAGE STRINGS

# rofi_delay=$(
#     printf "%s \n%s 1s\n%s 3s\n%s 5s\n%s 10s\n%s" \
#            "$lang_nodelay" "$lang_delay" "$lang_delay" "$lang_delay" "$lang_delay" |
#     rofi -dmenu -p "screenshot" -lines 5
# ) || exit 2
# Remove the delay because i dont want it
rofi_delay="⏰ Delay: 1s"

rofi_scr_type=$(
    printf "%s\n%s\n" "$lang_scr_fragment" "$lang_scr_whole" "$lang_scr_window" "$lang_scr_output" |
        rofi -dmenu -p "screenshot" -lines 2
) || exit 4

rofi_save_method=$(
    printf "%s\n%s\n%s\n" "$lang_copy_clipboard" "$lang_save_png" "$lang_save_jpg" |
        rofi -dmenu -p "screenshot" -lines 3
) || exit 3

delay() {
    if [ "$rofi_delay" = "$lang_delay 1s" ]; then
        notify-send "waiting" "1s"
        sleep 1
    elif [ "$rofi_delay" = "$lang_delay 3s" ]; then
        sleep 3
    elif [ "$rofi_delay" = "$lang_delay 5s" ]; then
        sleep 5
    elif [ "$rofi_delay" = "$lang_delay 10s" ]; then
        sleep 10
    fi
}

#if [ "$rofi_scr_type" = "$lang_scr_fragment" ]; then
#    screen_fragment=$(slop --highlight --tolerance=0 --color=0.3,0.4,0.6,0.4 -n -f '-g %g ')
#fi

# check if the file should be saved as jpg or png, set "$filepath" accordingly
filename="Screenshot $(date '+%Y-%m-%d, %R:%S')"
if [ "$rofi_save_method" = "$lang_save_jpg" ]; then
    filename="$filename.jpg"
else
    filename="$filename.png"
fi
filepath="$SAVE_DIR/$filename"
tempfilepath="/tmp/$filename"

# handle each option, calling the relevant grimblast command
# Area screenshot
# save: grimblast save area "$filepath"
# copy: grimblast copy area
if [ "$rofi_scr_type" = "$lang_scr_fragment" ] && [ "$rofi_save_method" = "$lang_copy_clipboard" ]; then
    grimblast copy area
elif [ "$rofi_scr_type" = "$lang_scr_fragment" ] && [ "$rofi_save_method" = "$lang_save_png" ]; then
    grimblast save area "$filepath"
elif [ "$rofi_scr_type" = "$lang_scr_fragment" ] && [ "$rofi_save_method" = "$lang_save_jpg" ]; then
    grimblast save area "$filepath"

# Fullscreen screenshot
# save: grimblast save screen "$filepath"
# copy: grimblast copy screen
elif [ "$rofi_scr_type" = "$lang_scr_whole" ] && [ "$rofi_save_method" = "$lang_copy_clipboard" ]; then
    delay
    grimblast copy screen
elif [ "$rofi_scr_type" = "$lang_scr_whole" ] && [ "$rofi_save_method" = "$lang_save_png" ]; then
    dleay
    grimblast save screen "$filepath"
elif [ "$rofi_scr_type" = "$lang_scr_whole" ] && [ "$rofi_save_method" = "$lang_save_jpg" ]; then
    delay
    grimblast save screen "$filepath"
# Window Screenshot
# save: grimblast save window "$filepath"
# copy: grimblast copy window
elif [ "$rofi_scr_type" = "$lang_scr_window" ] && [ "$rofi_save_method" = "$lang_copy_clipboard" ]; then
    grimblast copy window
elif [ "$rofi_scr_type" = "$lang_scr_window" ] && [ "$rofi_save_method" = "$lang_save_png" ]; then
    grimblast save window "$filepath"
elif [ "$rofi_scr_type" = "$lang_scr_window" ] && [ "$rofi_save_method" = "$lang_save_jpg" ]; then
    grimblast save window "$filepath"
# Current output screenshot
# save: grimblast save output "$filepath"
# copy: grimblast copy output
elif [ "$rofi_scr_type" = "$lang_scr_output" ] && [ "$rofi_save_method" = "$lang_copy_clipboard" ]; then
    grimblast copy output
elif [ "$rofi_scr_type" = "$lang_scr_output" ] && [ "$rofi_save_method" = "$lang_save_png" ]; then
    grimblast save output "$filepath"
elif [ "$rofi_scr_type" = "$lang_scr_output" ] && [ "$rofi_save_method" = "$lang_save_jpg" ]; then
    grimblast save output "$filepath"
fi
