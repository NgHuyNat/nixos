#!/run/current-system/sw/bin/bash
# switch-keyboard-layout.sh - Switch keyboard layout

# Simple keyboard layout switcher
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$current_layout" = "us" ]; then
    setxkbmap vn
    notify-send "Keyboard" "Switched to Vietnamese"
else
    setxkbmap us
    notify-send "Keyboard" "Switched to US English"
fi
