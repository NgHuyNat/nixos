# 🐧 NixOS Configuration

Cấu hình NixOS hoàn chỉnh với Hyprland, Home Manager và Flakes cho một hệ thống desktop hiện đại.

## 🔄 Áp dụng cấu hình

Dành cho hệ thống **đã có NixOS** và muốn áp dụng config này:

```bash
# Clone vào ~/.config/nixos (recommended location)
git clone https://github.com/NgHuyNat/nixos.git ~/.config/nixos
cd ~/.config/nixos

# Copy hardware configuration từ hệ thống hiện tại
sudo cp /etc/nixos/hardware-configuration.nix .

# Apply configuration
sudo nixos-rebuild switch --flake .#default
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

