#!/run/current-system/sw/bin/bash

url="$1"

if [ -z "$url" ]; then
    exit 1
fi

xdg-open "$url" >/dev/null 2>&1 &
disown
exit 0
