# waybar/modules/audio.ni            on-click = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle";
      on-click-right = "pavucontrol";
      on-scroll-up = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
      on-scroll-down = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";lick =      on-click = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle-mic";
      on-click-right = "pavucontrol";
      on-scroll-up = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --mic-inc";
      on-scroll-down = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --mic-dec";config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle";
      on-click-right = "pavucontrol";
      on-scroll-up = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
      on-scroll-down = "${config.home.homeDirectory}/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";Audio-related modules
{ config, pkgs, lib, ... }:

{
  config.waybar.modules.audio = {
    # === PULSEAUDIO MODULE ===
    pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} 󰂰 {volume}%";
      format-muted = "󰖁";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          "" "" "󰕾" ""
        ];
        ignored-sinks = [
          "Easy Effects Sink"
        ];
      };
      scroll-step = 1;
      on-click = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle";
      on-click-right = "pavucontrol -t 3";
      on-scroll-up = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
      on-scroll-down = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
      tooltip-format = "{icon} {desc} | {volume}%";
      smooth-scrolling-threshold = 1;
    };

    # === PULSEAUDIO MICROPHONE MODULE ===
    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = " {volume}%";
      format-source-muted = "";
      on-click = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle-mic";
      on-click-right = "pavucontrol -t 4";
      on-scroll-up = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --mic-inc";
      on-scroll-down = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --mic-dec";
      tooltip-format = "{source_desc} | {source_volume}%";
      scroll-step = 5;
    };

    # === WIREPLUMBER MODULE ===
    wireplumber = {
      format = "{icon} {volume} %";
      format-muted = " Mute";
      on-click = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle";
      on-click-right = "pavucontrol -t 3";
      on-scroll-up = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
      on-scroll-down = "$HOME/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
      format-icons = [
        "" "" "󰕾" ""
      ];
    };
  };
}
