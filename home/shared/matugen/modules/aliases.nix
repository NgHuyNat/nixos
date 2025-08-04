# matugen/aliases.nix - Shell aliases
{ config, pkgs, lib, ... }:

{
  # Optional: Create shell aliases for convenience
  home.shellAliases = {
    matugen-generate = "matugen image $HOME/Workspaces/Config/nixos/current_wallpaper";
    matugen-reload = "matugen image $HOME/Workspaces/Config/nixos/current_wallpaper && pkill -SIGUSR2 waybar";
  };
}