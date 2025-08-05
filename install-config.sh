#!/bin/bash

# 🚀 One-command install script for NixOS config
# This installs the new config after cleaning

set -e

echo "🚀 =================================="
echo "    NIXOS CONFIG INSTALLER"
echo "🚀 =================================="
echo ""

# Check if we're in clean GNOME environment
if [ ! -d ~/.config/nixos ]; then
    echo "📥 Cloning NixOS configuration..."
    git clone https://github.com/NgHuyNat/nixos.git ~/.config/nixos
else
    echo "📁 Config directory exists, updating..."
    cd ~/.config/nixos
    git pull origin main
fi

cd ~/.config/nixos

echo "🔧 Copying hardware configuration..."
sudo cp /etc/nixos/hardware-configuration.nix .

echo "👤 Checking username..."
CURRENT_USER=$(whoami)
if [ "$CURRENT_USER" != "nghuytan" ]; then
    echo "🔄 Adapting config for user: $CURRENT_USER"
    
    # Copy user config
    cp home/nghuytan.nix "home/$CURRENT_USER.nix"
    
    # Update flake.nix
    sed -i "s/nghuytan/$CURRENT_USER/g" flake.nix
    
    # Update users.nix
    sed -i "s/nghuytan/$CURRENT_USER/g" system/users.nix
fi

echo ""
echo "🔨 Building and applying NixOS config..."
echo "⏳ This may take 15-30 minutes for first build..."
sudo nixos-rebuild switch --flake .#default

echo ""
echo "✅ =================================="
echo "🎉 INSTALLATION COMPLETED!"
echo "✅ =================================="
echo ""
echo "🔄 Please reboot to start Hyprland:"
echo "   sudo reboot"
echo ""
echo "🎯 After reboot:"
echo "   - Login will start Hyprland"
echo "   - Super+Return = Terminal"
echo "   - Super+D = App launcher"
echo "   - Super+Q = Close window"
echo ""
echo "🎨 Enjoy your new NixOS desktop!"
