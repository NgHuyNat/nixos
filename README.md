# 🐧 NixOS Configuration

Cấu hình NixOS hoàn chỉnh với Hyprland, Home Manager và Flakes cho một hệ thống desktop hiện đại.

## 🔄 Áp dụng cấu hình

### 📦 **Hệ thống đã có NixOS sạch**
```bash
# Clone vào ~/.config/nixos (recommended location)
git clone https://github.com/NgHuyNat/nixos.git ~/.config/nixos
cd ~/.config/nixos

# Copy hardware configuration từ hệ thống hiện tại
sudo cp /etc/nixos/hardware-configuration.nix .

# Update flake inputs first (fix common build errors)
nix flake update

# Apply configuration (may take 20-30 minutes first time)
sudo nixos-rebuild switch --flake .#default --impure
```

### ⚠️ **Nếu gặp lỗi build lần đầu**
```bash
# Fix 1: Update flake lock
nix flake update

# Fix 2: Try with --impure flag
sudo nixos-rebuild switch --flake .#default --impure

# Fix 3: If still fails, check logs
sudo nixos-rebuild switch --flake .#default --show-trace

# Fix 4: Emergency fallback to older nixpkgs
sed -i 's/nixos-unstable/nixos-24.05/g' flake.nix
nix flake update
sudo nixos-rebuild switch --flake .#default
```

### 🧹 **Xóa config cũ (JaKooLiT/Hyprland khác)**
Nếu máy đã có Hyprland config khác và muốn xóa sạch:

```bash
# Tải script xóa nhanh
curl -O https://raw.githubusercontent.com/NgHuyNat/nixos/main/clean-nixos.sh
chmod +x clean-nixos.sh

# Chạy script xóa (sẽ reset về GNOME minimal)
./clean-nixos.sh

# Reboot
sudo reboot

# Sau khi reboot, cài config mới
curl -O https://raw.githubusercontent.com/NgHuyNat/nixos/main/install-config.sh
chmod +x install-config.sh
./install-config.sh

# Reboot vào Hyprland
sudo reboot
```

## 📋 Tổng quan

Đây là cấu hình NixOS hoàn chỉnh bao gồm:
- **Desktop Environment**: Hyprland (Wayland compositor)
- **Package Management**: Nix Flakes + Home Manager  
- **Shell**: Zsh với Powerlevel10k
- **Terminal**: Kitty
- **Editor**: Neovim với cấu hình tùy chỉnh
- **Theme**: Dynamic theming với Matugen
- **Notification**: SwayNotificationCenter
- **Bar**: Waybar
- **Launcher**: Rofi

## 🏗️ Cấu trúc Project

```
nixos/
├── configuration.nix           # Main system configuration
├── flake.nix                  # Flake configuration
├── hardware-configuration.nix # Hardware-specific config
├── rebuild.sh                 # Quick rebuild script
├── desktop/                   # Desktop environment configs
├── dotfiles/                  # Application dotfiles
├── home/                      # Home Manager configurations
├── programs/                  # Program-specific configurations
├── system/                    # System-level configurations
└── wallpapers/               # Collection of wallpapers
```

## 👤 Tùy chỉnh user

1. **Đổi tên trong `system/users.nix`**
2. **Tạo home config**: `cp home/nghuytan.nix home/yourusername.nix`
3. **Cập nhật `flake.nix`**

## 🎯 Phím tắt Hyprland

- `Super + Return`: Terminal
- `Super + D`: Rofi launcher  
- `Super + Q`: Đóng window
- `Super + F`: Fullscreen
- `Super + 1-9`: Chuyển workspace

## 🔧 Troubleshooting

### Màn hình đen sau login
```bash
# Switch to TTY
Ctrl + Alt + F2

# Rebuild config
sudo nixos-rebuild switch --flake /etc/nixos#default
```

### Lỗi rebuild
```bash
# Xem log chi tiết
sudo nixos-rebuild switch --flake .#default --show-trace

# Rollback
sudo nixos-rebuild switch --rollback
```

---

