#!/run/current-system/sw/bin/bash
# waybar-scripts.sh - Waybar utility scripts

case "$1" in
    "--nmtui")
        kitty nmtui &
        ;;
    *)
        echo "Usage: $0 [--nmtui]"
        ;;
esac
