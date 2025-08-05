#!/run/current-system/sw/bin/bash
# KooLsDotsUpdate.sh - Update configuration

cd ~/.config/nixos 2>/dev/null || cd /etc/nixos
git pull
notify-send "Update" "Configuration updated"
