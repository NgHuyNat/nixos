#!/run/current-system/sw/bin/bash
# Distro_update.sh - System update

kitty --title "System Update" -e bash -c "
echo 'Updating NixOS system...'
sudo nixos-rebuild switch --upgrade
echo 'Update completed!'
read -p 'Press Enter to close...'
"
