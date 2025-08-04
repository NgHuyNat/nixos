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
        # Safe auto-detect for all monitors - VM compatible
        ", preferred, auto, 1"
      ];
    };
  };
}
