#!/run/current-system/sw/bin/bash
# WaybarScripts.sh - Main waybar utility scripts

case "$1" in
    "--term")
        kitty &
        ;;
    "--nvtop")
        kitty nvtop &
        ;;
    "--btop")
        kitty btop &
        ;;
    "--nmtui")
        kitty nmtui &
        ;;
    *)
        echo "Usage: $0 [--term|--nvtop|--btop|--nmtui]"
        ;;
esac
