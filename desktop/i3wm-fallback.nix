# i3wm configuration as fallback for Hyprland in VM
{ config, pkgs, ... }:

{
  # Enable X11 with i3
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    windowManager.i3.enable = true;
    
    # Configure for VM
    videoDrivers = [ "modesetting" ];
  };

  # i3wm packages
  environment.systemPackages = with pkgs; [
    i3
    i3status
    i3lock
    dmenu
    kitty
    firefox
    rofi
    feh  # wallpaper
  ];

  # User session
  services.xserver.displayManager.defaultSession = "none+i3";
}
