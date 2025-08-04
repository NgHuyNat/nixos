# 🐧 NixOS Configuration - Hướng dẫn cài đặt từ A-Z

Cấu hình NixOS hoàn chỉnh với Hyprland, Home Manager và Flakes cho một hệ thống desktop hiện đại.

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
├── flake.nix                  # Flake configuration với inputs/outputs
├── flake.lock                 # Flake lock file (auto-generated)
├── hardware-configuration.nix # Hardware-specific config (auto-generated)
├── rebuild.sh                 # Quick rebuild script
├── desktop/                   # Desktop environment configs
│   ├── default.nix            # Desktop module imports
│   ├── hyprland.nix           # Hyprland window manager
│   ├── audio.nix              # Audio system (PipeWire)
│   ├── graphics.nix           # Graphics drivers
│   └── fonts.nix              # System fonts
├── dotfiles/                  # Application dotfiles
│   ├── nvim/                  # Neovim configuration
│   ├── tmux/                  # Tmux configuration
│   └── zsh/                   # Zsh configuration
└── home/                      # Home Manager configurations
    ├── default.nix            # Common home config (imports all shared)
    ├── nghuytan.nix           # User-specific config
    ├── newuser.nix            # Template for new users
    └── shared/                # Shared configurations
        ├── git.nix            # Git configuration
        ├── kitty.nix          # Kitty terminal
        ├── neovim.nix         # Neovim (calls dotfiles)
        ├── zsh.nix            # Zsh shell
        ├── hypr/              # Hyprland configs
        ├── rofi/              # Rofi launcher
        ├── waybar/            # Waybar status bar
        ├── swaync/            # SwayNotificationCenter
        └── matugen/           # Dynamic theming
├── programs/                  # Program-specific configurations
│   ├── default.nix           # Program imports
│   ├── development.nix       # Development tools & IDEs
│   ├── gaming.nix            # Gaming setup (Steam, etc.)
│   ├── multimedia.nix        # Media applications
│   └── python.nix            # Python development environment
├── system/                    # System-level configurations
│   ├── default.nix           # System module imports
│   ├── boot.nix              # Boot configuration
│   ├── users.nix             # User accounts
│   ├── networking.nix        # Network settings
│   ├── security.nix          # Security settings
│   ├── locale.nix            # Localization
│   └── packages.nix          # System packages
└── wallpapers/               # Collection of wallpapers
```

---

# 📦 HƯỚNG DẪN CÀI ĐẶT NIXOS TỪ ĐẦU

## 🔽 Bước 1: Tải NixOS ISO

1. **Truy cập trang chủ NixOS**: https://nixos.org/download.html
2. **Tải ISO Minimal**: Chọn "Minimal ISO image" (khoảng 900MB)
3. **Tạo USB boot**: 
   - **Windows**: Sử dụng Rufus hoặc Etcher
   - **Linux**: Sử dụng `dd` command
   ```bash
   sudo dd if=nixos-minimal-xx.xx-x86_64-linux.iso of=/dev/sdX bs=4M status=progress
   ```

## 💽 Bước 2: Boot từ USB và chuẩn bị

1. **Boot từ USB** và chọn "NixOS Live"
2. **Kết nối internet**:
   ```bash
   # Wifi
   sudo wpa_supplicant -B -i wlan0 -c <(wpa_passphrase 'SSID' 'password')
   
   # Ethernet (tự động)
   ping google.com  # Test connection
   ```

3. **Trở thành root**:
   ```bash
   sudo su
   ```

## 🗂️ Bước 3: Phân vùng ổ cứng

### Cách 1: Sử dụng UEFI (Khuyến nghị)
```bash
# Xem các ổ cứng
lsblk

# Phân vùng ổ cứng (thay /dev/sda bằng ổ cứng của bạn)
parted /dev/sda -- mklabel gpt

# Boot partition (EFI)
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 1 esp on

# Root partition (còn lại)
parted /dev/sda -- mkpart primary 512MiB 100%
```

### Cách 2: Legacy BIOS
```bash
parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MiB 100%
parted /dev/sda -- set 1 boot on
```

## 🏗️ Bước 4: Format và mount

### UEFI System:
```bash
# Format partitions
mkfs.fat -F 32 -n boot /dev/sda1      # Boot partition
mkfs.ext4 -L nixos /dev/sda2          # Root partition

# Mount
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

### Legacy BIOS:
```bash
mkfs.ext4 -L nixos /dev/sda1
mount /dev/disk/by-label/nixos /mnt
```

## ⚙️ Bước 5: Tạo cấu hình ban đầu

```bash
# Tạo configuration
nixos-generate-config --root /mnt

# Kiểm tra file đã tạo
ls /mnt/etc/nixos/
```

## 🔧 Bước 6: Chỉnh sửa configuration cơ bản

```bash
nano /mnt/etc/nixos/configuration.nix
```

**Thêm những dòng sau:**
```nix
# Enable experimental features
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Enable NetworkManager
networking.networkmanager.enable = true;

# Add user
users.users.nghuytan = {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ];
  packages = with pkgs; [
    git
    wget
    curl
  ];
};

# Enable SSH (tùy chọn)
services.openssh.enable = true;
```

## 💾 Bước 7: Cài đặt NixOS

```bash
# Cài đặt hệ thống
nixos-install

# Đặt password cho root khi được hỏi
# Reboot
reboot
```

---

# 🎨 SỬ DỤNG CẤU HÌNH NGHUYTAN

## 📥 Bước 1: Clone cấu hình

Sau khi boot vào NixOS mới:

```bash
# Login với user đã tạo
# Cài git nếu chưa có
nix-shell -p git

# Tạo thư mục Workspaces/Config
mkdir -p ~/Workspaces/Config
cd ~/Workspaces/Config

# Clone repository
git clone https://github.com/NgHuyNat/nixos.git
cd nixos
```

## 🔄 Bước 2: Backup và setup

```bash
# Backup cấu hình cũ của repo
cp /etc/nixos/configuration.nix ./configuration.nix.backup

# So sánh hardware config
echo "🔍 So sánh hardware configurations..."
echo "Hardware config từ /etc/nixos/:"
sudo cat /etc/nixos/hardware-configuration.nix | grep -E "(device|fsType)"

cp /etc/nixos/hardware-configuration.nix hardware-configuration.nix

cat hardware-configuration.nix

# Xác nhận hardware config đã đúng
echo "🔍 Kiểm tra hardware configuration..."
echo "1. Kiểm tra UUID partition:"
lsblk -f
echo ""
echo "2. So sánh với file config:"
grep -E "(device|fsType)" hardware-configuration.nix
echo ""
echo "3. Kiểm tra kernel modules:"
lsmod | grep -E "(nvme|ahci|xhci|intel)"
echo ""
echo "4. Kiểm tra platform:"
uname -m
```

**💡 Những điều cần kiểm tra:**
- ✅ **UUID trong file phải khớp với `lsblk -f`**
- ✅ **Kernel modules phải có trong `lsmod`**  
- ✅ **Platform phải là `x86_64-linux`**
- ✅ **Boot partition phải là `/boot` với fsType `vfat`**
- ✅ **Root partition phải là `/` với fsType `ext4`**

## 👤 Bước 3: Thay đổi thông tin user

1. **Đổi tên trong `system/users.nix`**:
```bash
nano system/users.nix
# Thay 'nghuytan' thành tên user của bạn
```

2. **Tạo home config cho user mới**:
```bash
cp home/nghuytan.nix home/yourusername.nix
nano home/yourusername.nix
# Cập nhật username và home directory
```

3. **Cập nhật `flake.nix`**:
```bash
nano flake.nix
# Thay đổi home-manager.users section
```

## 🚀 Bước 4: Apply cấu hình

```bash
# Build và apply
sudo nixos-rebuild switch --flake .#default

# Nếu gặp lỗi, thử:
sudo nixos-rebuild switch --flake .#default --impure
```

## 🔄 Bước 5: Reboot và enjoy!

```bash
sudo reboot
```

---

# 🎛️ TÙY CHỈNH VÀ CẤU HÌNH

## 📂 Cấu hình quan trọng

### Thay đổi wallpaper
```bash
# Thêm wallpaper vào thư mục
cp your-wallpaper.jpg ~/Workspaces/Config/nixos/wallpapers/

# Chạy wallpaper picker
~/Workspaces/Config/nixos/home/shared/matugen/scripts/wppicker.sh
```

### Thêm phần mềm
1. **System packages**: Edit `system/packages.nix`
2. **User packages**: Edit `home/yourusername.nix`
3. **Development tools**: Edit `programs/development.nix`

### Git configuration
```bash
nano home/shared/git.nix
# Cập nhật email và tên
```

## 🎯 Phím tắt Hyprland quan trọng

- `Super + Return`: Mở terminal
- `Super + D`: Mở Rofi launcher  
- `Super + Q`: Đóng window
- `Super + M`: Thoát Hyprland
- `Super + F`: Fullscreen
- `Super + V`: Toggle floating
- `Super + 1-9`: Chuyển workspace

## 🔧 Troubleshooting

### Lỗi rebuild
```bash
# Xem log chi tiết
sudo nixos-rebuild switch --flake .#default --show-trace

# Rollback nếu cần
sudo nixos-rebuild switch --rollback
```

### Lỗi Home Manager
```bash
home-manager switch --flake .#yourusername
```

### Reset cấu hình
```bash
# Copy lại hardware config
sudo cp /etc/nixos/hardware-configuration.nix .

# Rebuild
sudo nixos-rebuild switch --flake .#default
```

## 📚 Tài liệu tham khảo

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [NixOS Search](https://search.nixos.org/)

## 💡 Tips và Tricks

1. **Luôn backup** trước khi thay đổi lớn
2. **Test từng module** một cách riêng biệt
3. **Sử dụng `nixos-option`** để tìm options
4. **Tham gia community** NixOS Discord/Reddit
5. **Đọc source code** của packages khác để học

---

*Made with ❤️ by Nghuytan - Enjoy your NixOS journey! -- Source vuongmanhnghia*
#   n i x - c o n f i g 
 
 