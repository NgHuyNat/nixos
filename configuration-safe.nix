# configuration-safe.nix - Simplified safe configuration
{ config, pkgs, inputs ? {}, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system
    ./desktop/safe-mode.nix  # Safe desktop mode instead of full Hyprland
    ./programs/default.nix
  ];
  
  # SSH configuration  
  programs.ssh.startAgent = true;
  services.openssh.enable = true;
  
  # Disable nscd
  services.nscd.enable = false;
  services.resolved.enable = true;
  system.nssModules = lib.mkForce [];
    
  # Enable Nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System version
  system.stateVersion = "25.05";
}
