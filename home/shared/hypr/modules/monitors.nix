# ███╗   ███╗ ██████╗ ███╗   ██╗██╗████████╗ ██████╗ ██████╗ ███████╗
# ████╗ ████║██╔═══██╗████╗  ██║██║╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
# ██╔████╔██║██║   ██║██╔██╗ ██║██║   ██║   ██║   ██║██████╔╝███████╗
# ██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║   ██║   ██║██╔══██╗╚════██║
# ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝██║  ██║███████║
# ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
#--------------------------------------------------------------------
# Monitor Configuration:
# - External Full HD monitor (1920x1080@180Hz) as primary at position 0x0
# - Laptop display (1920x1080@144Hz) as secondary at position 1920x0 (to the right)
# - Auto-detect fallback for other monitors
#--------------------------------------------------------------------


{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        # External Full HD monitor (DisplayPort) - Primary, 180Hz
        "DP-2, 1920x1080@180, 0x0, 1"
        # Laptop internal display (Full HD) - Secondary, positioned to the right, 144Hz
        "eDP-1, 1920x1080@144, 1920x0, 1"
        # Fallback auto-detect for any other monitors
        ", preferred, auto, 1"
        # Alternative external monitor connections
        # "HDMI-A-1, 1920x1080@180, 0x0, 1"
        # "DP-1, 1920x1080@180, 0x0, 1"
      ];
    };
  };
}
