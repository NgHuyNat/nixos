{ config, pkgs, ... }:

{
  # === PROPRIETARY SOFTWARE SUPPORT ===
  nixpkgs.config.allowUnfree = true;  # Required for NVIDIA proprietary drivers
  
  # === GRAPHICS HARDWARE SUPPORT ===
  hardware.graphics = {
    enable = true;       # Enable graphics drivers
    enable32Bit = true;  # Enable 32-bit graphics support (required for gaming/Steam)
    
    # Additional graphics packages for enhanced functionality
    extraPackages = with pkgs; [
      # VM-compatible graphics packages
      mesa                       # Open source graphics drivers
      vulkan-loader              # Vulkan graphics API loader
      vulkan-validation-layers   # Vulkan debugging and validation
      # nvidia-vaapi-driver      # Disabled for VM compatibility
    ];
    
    # Force software rendering for VM
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
    ];
  };

  # === VM-SPECIFIC GRAPHICS CONFIGURATION ===
  # Disable NVIDIA-specific settings for VM compatibility
  # services.xserver.videoDrivers = [ "modesetting" ];  # Use generic modesetting driver

  # === NVIDIA DRIVER CONFIGURATION ===
  services.xserver.videoDrivers = ["nvidia"];  # Use NVIDIA proprietary driver

  hardware.nvidia = {
    # Enable modesetting for Wayland support (required for GNOME Wayland)
    modesetting.enable = true;

    # Use latest stable NVIDIA driver for best performance and features
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # Enable NVIDIA X Server Settings GUI tool
    nvidiaSettings = true;

    # Use proprietary driver (set to true for open-source kernel module)
    open = false;  # Keep false for stability with most GPUs

    # Enable power management features
    powerManagement.enable = true;
  };

  # === KERNEL CONFIGURATION FOR NVIDIA ===
  # Load necessary kernel modules for NVIDIA functionality
  boot.kernelModules = [ 
    "nvidia"         # Main NVIDIA driver module
    "nvidia_modeset" # Modesetting support for Wayland
    "nvidia_uvm"     # Unified Virtual Memory support
    "nvidia_drm"     # Direct Rendering Manager support
  ];
  # Blacklist open-source Nouveau driver to prevent conflicts
  boot.blacklistedKernelModules = [ "nouveau" ];
  
  # === KERNEL BOOT PARAMETERS ===
  boot.kernelParams = [
    "nvidia-drm.modeset=1"  # Enable NVIDIA DRM modesetting for Wayland
  ];

  # === ADDITIONAL GRAPHICS TOOLS ===
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit  # NVIDIA container runtime for Docker
    libva-utils               # VA-API utilities for testing video acceleration
    vulkan-tools              # Vulkan utilities (vulkaninfo, vkcube)
  ];
} 
