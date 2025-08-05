# Safe mode desktop configuration - fallback for troubleshooting
{ config, pkgs, ... }:

{
  imports = [
    ./i3wm-fallback.nix  # Use i3wm as safe fallback
    ./audio.nix
    ./fonts.nix
  ];
  
  # Disable potentially problematic services
  services.hypridle.enable = lib.mkForce false;
  programs.hyprland.enable = lib.mkForce false;
}