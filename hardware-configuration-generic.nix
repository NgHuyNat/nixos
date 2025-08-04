# hardware-configuration-generic.nix - Generic hardware configuration template
# This file provides a safe fallback for deployment on different hardware
# The actual hardware-configuration.nix will be generated during installation

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix") # Support for VMs
  ];

  # Generic kernel modules that work on most Intel systems
  boot.initrd.availableKernelModules = [ 
    "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"
    "ehci_pci" "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ 
    "kvm-intel"  # Intel virtualization
    "kvm-amd"    # AMD virtualization (one will work, other ignored)
  ];
  boot.extraModulePackages = [ ];

  # Filesystem configuration - THESE MUST BE UPDATED DURING INSTALLATION
  # Use nixos-generate-config to replace this file with actual hardware config
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos-root";  # Use label instead of UUID
      fsType = "ext4";
      options = [ "defaults" "noatime" ];
    };
    
    "/boot" = {
      device = "/dev/disk/by-label/boot";        # Use label instead of UUID  
      fsType = "vfat";
      options = [ "defaults" "umask=0077" ];
    };
  };

  # Swap configuration - adjust as needed
  swapDevices = [
    # Uncomment and adjust as needed:
    # { device = "/dev/disk/by-label/swap"; }
    # { device = "/swapfile"; size = 8192; }  # 8GB swapfile
  ];

  # Network configuration
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

  # Hardware specific optimizations
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # Enable firmware updates and hardware support
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  
  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  
  # Additional hardware support
  services.fwupd.enable = true;  # Firmware updates
  services.thermald.enable = true;  # Intel thermal management
}
