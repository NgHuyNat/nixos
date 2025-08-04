#!/usr/bin/env bash
# script-wrapper.sh - Wrapper to load config paths and execute scripts

# Load detected config paths
if [ -f "$HOME/.config/nixos-paths.env" ]; then
    source "$HOME/.config/nixos-paths.env"
fi

# Fallback paths if detection failed
NIXOS_CONFIG_PATH="${NIXOS_CONFIG_PATH:-$HOME/Workspaces/Config/nixos}"
NIXOS_SCRIPTS_PATH="${NIXOS_SCRIPTS_PATH:-$NIXOS_CONFIG_PATH/home/shared/hypr/scripts}"

# Function to find and execute script
execute_script() {
    local script_name="$1"
    shift # Remove script name from arguments
    
    # Try to find script in various locations
    local script_locations=(
        "$NIXOS_SCRIPTS_PATH/$script_name"
        "$HOME/.config/hypr/scripts/$script_name"
        "$HOME/.nixos-config/home/shared/hypr/scripts/$script_name"
    )
    
    for script_path in "${script_locations[@]}"; do
        if [ -x "$script_path" ]; then
            exec "$script_path" "$@"
            return $?
        elif [ -f "$script_path" ]; then
            exec bash "$script_path" "$@"
            return $?
        fi
    done
    
    # Script not found
    echo "❌ Script not found: $script_name" >&2
    echo "Searched in:" >&2
    printf "  - %s\n" "${script_locations[@]}" >&2
    return 1
}

# Execute the requested script
if [ $# -gt 0 ]; then
    execute_script "$@"
else
    echo "Usage: $0 <script-name> [arguments...]"
    exit 1
fi
