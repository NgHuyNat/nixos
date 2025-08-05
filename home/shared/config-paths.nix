# config-paths.nix - Dynamic path detection for portable configuration
{ config, lib, pkgs, ... }:

let
  # Default config path that can be overridden
  defaultConfigPath = "${config.home.homeDirectory}/.config/nixos";
  
  # Create a wrapper script for all script executions
  scriptWrapper = pkgs.writeShellScript "nixos-script-wrapper" ''
    # Load detected config paths
    if [ -f "$HOME/.config/nixos-paths.env" ]; then
        source "$HOME/.config/nixos-paths.env"
    fi

    # Fallback paths if detection failed
    NIXOS_CONFIG_PATH="''${NIXOS_CONFIG_PATH:-${defaultConfigPath}}"
    NIXOS_SCRIPTS_PATH="''${NIXOS_SCRIPTS_PATH:-$NIXOS_CONFIG_PATH/home/shared/hypr/scripts}"

    # Function to find and execute script
    execute_script() {
        local script_name="$1"
        shift # Remove script name from arguments
        
        # Try to find script in various locations
        local script_locations=(
            "$NIXOS_SCRIPTS_PATH/$script_name"
            "$HOME/.config/hypr/scripts/$script_name"
            "$HOME/.nixos-config/home/shared/hypr/scripts/$script_name"
            "${defaultConfigPath}/home/shared/hypr/scripts/$script_name"
        )
        
        for script_path in "''${script_locations[@]}"; do
            if [ -x "$script_path" ]; then
                exec "$script_path" "$@"
                return $?
            elif [ -f "$script_path" ]; then
                exec bash "$script_path" "$@"
                return $?
            fi
        done
        
        # Create a basic fallback for common scripts
        case "$script_name" in
            "wbrestart.sh")
                pkill waybar 2>/dev/null; sleep 1; waybar &
                ;;
            "volume.sh")
                case "$1" in
                    "--inc") pamixer -i 5 ;;
                    "--dec") pamixer -d 5 ;;
                    "--toggle") pamixer -t ;;
                    *) echo "Volume: $(pamixer --get-volume)%" ;;
                esac
                ;;
            "brightness.sh")
                case "$1" in
                    "--inc") brightnessctl set +5% ;;
                    "--dec") brightnessctl set 5%- ;;
                    *) echo "Brightness: $(brightnessctl get)" ;;
                esac
                ;;
            "hyprlock.sh")
                hyprlock
                ;;
            "wlogout.sh")
                wlogout
                ;;
            *)
                echo "⚠️  Script fallback not available for: $script_name" >&2
                notify-send "Script Error" "Script not found: $script_name" 2>/dev/null || true
                return 1
                ;;
        esac
    }

    # Execute the requested script
    if [ $# -gt 0 ]; then
        execute_script "$@"
    else
        echo "Usage: $0 <script-name> [arguments...]"
        exit 1
    fi
  '';
in
{
  # Export paths for use by other modules
  home.sessionVariables = {
    NIXOS_CONFIG_PATH = defaultConfigPath;
    NIXOS_SCRIPTS_PATH = "${defaultConfigPath}/home/shared/hypr/scripts";
    NIXOS_WALLPAPERS_PATH = "${defaultConfigPath}/wallpapers";
    NIXOS_CURRENT_WALLPAPER = "${defaultConfigPath}/current_wallpaper";
    NIXOS_SCRIPT_WRAPPER = "${scriptWrapper}";
  };

  # Make script wrapper available in PATH
  home.packages = [ scriptWrapper ];

  # Create a config detection and setup script
  home.activation.setupNixOSPaths = config.lib.dag.entryAfter ["writeBoundary"] ''
    echo "🔍 Setting up NixOS configuration paths..."
    
    # Detect actual config path and create environment file
    CONFIG_CANDIDATES=(
      "$HOME/.config/nixos"
      "$HOME/.config/nixos"
      "$HOME/nixos-config"
      "$HOME/nixos"
      "$HOME/Documents/nixos"
    )
    
    DETECTED_PATH=""
    for path in "''${CONFIG_CANDIDATES[@]}"; do
      if [ -f "$path/flake.nix" ] && [ -d "$path/home" ]; then
        DETECTED_PATH="$path"
        break
      fi
    done
    
    # Create environment file
    mkdir -p "$HOME/.config"
    echo "# Auto-generated NixOS config paths - $(date)" > "$HOME/.config/nixos-paths.env"
    
    if [ -n "$DETECTED_PATH" ]; then
      echo "export NIXOS_CONFIG_PATH=\"$DETECTED_PATH\"" >> "$HOME/.config/nixos-paths.env"
      echo "export NIXOS_SCRIPTS_PATH=\"$DETECTED_PATH/home/shared/hypr/scripts\"" >> "$HOME/.config/nixos-paths.env"
      echo "export NIXOS_WALLPAPERS_PATH=\"$DETECTED_PATH/wallpapers\"" >> "$HOME/.config/nixos-paths.env"
      echo "export NIXOS_CURRENT_WALLPAPER=\"$DETECTED_PATH/current_wallpaper\"" >> "$HOME/.config/nixos-paths.env"
      
      # Create symlink for quick access
      ln -sf "$DETECTED_PATH" "$HOME/.nixos-config" 2>/dev/null || true
      
      echo "✅ NixOS config detected at: $DETECTED_PATH"
    else
      # Use default path
      echo "export NIXOS_CONFIG_PATH=\"${defaultConfigPath}\"" >> "$HOME/.config/nixos-paths.env"
      echo "export NIXOS_SCRIPTS_PATH=\"${defaultConfigPath}/home/shared/hypr/scripts\"" >> "$HOME/.config/nixos-paths.env"
      echo "export NIXOS_WALLPAPERS_PATH=\"${defaultConfigPath}/wallpapers\"" >> "$HOME/.config/nixos-paths.env"
      echo "export NIXOS_CURRENT_WALLPAPER=\"${defaultConfigPath}/current_wallpaper\"" >> "$HOME/.config/nixos-paths.env"
      
      echo "⚠️  Using default path: ${defaultConfigPath}"
    fi
    
    # Ensure required directories exist
    source "$HOME/.config/nixos-paths.env"
    mkdir -p "''${NIXOS_WALLPAPERS_PATH}" "''${NIXOS_SCRIPTS_PATH}" 2>/dev/null || true
    
    # Create current_wallpaper if not exists
    if [ ! -f "''${NIXOS_CURRENT_WALLPAPER}" ] && [ -d "''${NIXOS_WALLPAPERS_PATH}" ]; then
      find "''${NIXOS_WALLPAPERS_PATH}" -type f \( -name "*.jpg" -o -name "*.png" \) | head -1 > "''${NIXOS_CURRENT_WALLPAPER}" 2>/dev/null || true
    fi
    
    echo "🎯 NixOS configuration paths setup completed!"
  '';
}
