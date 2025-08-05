#!/run/current-system/sw/bin/bash
# change-blur.sh - Toggle blur effects (placeholder)

# Toggle blur effects in Hyprland
if pgrep hyprland > /dev/null; then
    notify-send "Blur" "Blur effects toggled"
else
    echo "Hyprland not running"
fi
