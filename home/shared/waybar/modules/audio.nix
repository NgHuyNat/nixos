# Audio-related modules
{ config, pkgs, lib, ... }:

{
  # === PULSEAUDIO MODULE ===
  pulseaudio = {
    format = "{icon} {volume}%";
    format-bluetooth = "{icon} 󰂰 {volume}%";
    format-muted = "󰖁";
    format-icons = {
      headphone = "󰋋";
      hands-free = "󰋎";
      headset = "󰋎";
      phone = "";
      portable = "";
      car = "";
      default = ["󰕿" "󰖀" "󰕾"];
    };
    on-click = "pamixer --toggle-mute";
    on-click-right = "pavucontrol";
    on-scroll-up = "pamixer -i 5";
    on-scroll-down = "pamixer -d 5";
    scroll-step = 5;
    tooltip = true;
    tooltip-format = "{desc}";
  };

  # === MICROPHONE MODULE ===
  microphone = {
    format = "{icon}";
    format-muted = "󰍭";
    format-icons = ["󰍬"];
    on-click = "pamixer --default-source --toggle-mute";
    on-click-right = "pavucontrol";
    on-scroll-up = "pamixer --default-source -i 5";
    on-scroll-down = "pamixer --default-source -d 5";
    scroll-step = 5;
    tooltip = true;
    tooltip-format = "Microphone: {desc}";
  };
}
