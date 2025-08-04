# ███╗   ███╗ ██████╗ ███╗   ██╗██╗████████╗ ██████╗ ██████╗ ███████╗
# ████╗ ████║██╔═══██╗████╗  ██║██║╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
# ██╔████╔██║██║   ██║██╔██╗ ██║██║   ██║   ██║   ██║██████╔╝███████╗
# ██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║   ██║   ██║██╔══██╗╚════██║
# ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝██║  ██║███████║
# ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
#--------------------------------------------------------------------
# Monitor Configuration:
# - External 2K monitor (2560x1440@180Hz) as primary at position 0x0
# - Laptop display (1920x1080@144Hz) as secondary at position 2560x0 (to the right)
# - Auto-detect fallback for other monitors
#--------------------------------------------------------------------


{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        # External 2K monitor (DisplayPort) - Primary
        "DP-2, 2560x1440@180, 0x0, 1"
        # Laptop internal display (Full HD) - Secondary, positioned to the right
        "eDP-1, 1920x1080@144, 2560x0, 1"
        # Fallback auto-detect for any other monitors
        ", preferred, auto, 1"
        # Alternative external monitor connections
        # "HDMI-A-1, 2560x1440@180, 0x0, 1"
        # "DP-1, 2560x1440@180, 0x0, 1"
      ];
    };
  };
}
