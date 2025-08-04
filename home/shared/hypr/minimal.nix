# Minimal Hyprland config for debugging
{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Minimal monitor config
      monitor = [
        ", preferred, auto, 1"
      ];
      
      # Basic environment variables for VM
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland"
      ];
      
      # Minimal keybindings
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, D, exec, rofi -show drun"
      ];
      
      # Basic window rules
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };
      
      # Disable animations for better VM performance  
      animations = {
        enabled = false;
      };
      
      # Basic decoration
      decoration = {
        rounding = 5;
        shadow_render_power = 0;
        blur = {
          enabled = false;
        };
      };
    };
  };
}
