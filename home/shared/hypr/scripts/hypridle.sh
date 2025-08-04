#!/usr/bin/env bash
# hypridle.sh - Control hypridle daemon

case "$1" in
    "status")
        # Check if hypridle is running
        if pgrep -x hypridle > /dev/null; then
            echo "󰒲" # Active icon
        else
            echo "󰒳" # Inactive icon
        fi
        ;;
    "toggle")
        # Toggle hypridle daemon
        if pgrep -x hypridle > /dev/null; then
            pkill hypridle
            notify-send "💤 Hypridle" "Screen idle disabled"
        else
            hypridle &
            notify-send "👁️ Hypridle" "Screen idle enabled"
        fi
        ;;
    "start")
        if ! pgrep -x hypridle > /dev/null; then
            hypridle &
            echo "✅ Hypridle started"
        else
            echo "ℹ️ Hypridle already running"
        fi
        ;;
    "stop")
        if pgrep -x hypridle > /dev/null; then
            pkill hypridle
            echo "✅ Hypridle stopped"
        else
            echo "ℹ️ Hypridle not running"
        fi
        ;;
    *)
        echo "Usage: $0 {status|toggle|start|stop}"
        exit 1
        ;;
esac
