# Custom waybar modules
{ config, pkgs, lib, ... }:

{
  config.waybar.modules.custom = {
    # === TERMINAL MODULE ===
    "custom/terminal" = {
      format = " ";
      on-click = "kitty";
      tooltip = true;
      tooltip-format = "Launch Terminal";
    };

    # === POWER MENU ===
    "custom/power" = {
      format = "⏻";
      on-click = "wlogout";
      tooltip = true;
      tooltip-format = "Power Menu";
    };

    # === NOTIFICATION CENTER ===
    "custom/notification" = {
      format = "󰂚";
      on-click = "swaync-client -t -sw";
      tooltip = true;
      tooltip-format = "Notification Center";
    };

    # === WALLPAPER PICKER ===
    "custom/wallpaper" = {
      format = "󰸉";
      on-click = "bash -c 'cd ~/.config/nixos 2>/dev/null && ./home/shared/matugen/scripts/wppicker.sh || rofi -show filebrowser'";
      tooltip = true;
      tooltip-format = "Wallpaper Picker";
    };

    # === KEYBOARD LAYOUT ===
    "custom/keyboard" = {
      format = "󰌌";
      on-click = "bash -c 'setxkbmap -query | grep layout'";
      tooltip = true;
      tooltip-format = "Keyboard Layout";
    };

    # === SYSTEM UPDATE ===
    "custom/updates" = {
      format = "󰚰 {}";
      interval = 7200;  # Check every 2 hours
      exec = "echo 0";  # Placeholder - NixOS doesn't use traditional updates
      on-click = "kitty --title 'System Update' -e bash -c 'sudo nixos-rebuild switch --upgrade'";
      tooltip = true;
      tooltip-format = "System Update";
    };

    # === THEME TOGGLE ===
    "custom/theme" = {
      format = "{}";
      exec = "echo '󰔎'";  # Dark theme icon
      on-click = "notify-send 'Theme' 'Theme toggle not implemented yet'";
      tooltip = true;
      tooltip-format = "Toggle Theme";
    };

    # === IDLE INHIBITOR ===
    "custom/idle" = {
      format = "{icon}";
      format-icons = {
        "activated" = "󰒳";
        "deactivated" = "󰒲";
      };
      exec = "bash -c 'if pgrep hypridle > /dev/null; then echo activated; else echo deactivated; fi'";
      on-click = "bash -c 'if pgrep hypridle > /dev/null; then pkill hypridle; else hypridle & fi'";
      interval = 5;
      tooltip = true;
      tooltip-format = "Toggle Idle";
    };
  };
}