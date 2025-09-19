#!/bin/bash

# Claude Desktop Replacement - Main Launcher
# This script provides multiple ways to access Claude functionality

# Error handling function
error_handler() {
    local line_no=$1
    local error_code=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [claude-terminal.sh] ERROR: Script failed at line $line_no with exit code $error_code" >> "$SCRIPT_DIR/debug.log" 2>/dev/null || true
    echo "Script error occurred. Check debug.log for details."
    exit $error_code
}

# Set up error handling
trap 'error_handler ${LINENO} $?' ERR
set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Debug logging
DEBUG_LOG="$SCRIPT_DIR/debug.log"

# Function to log debug messages
debug_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [claude-terminal.sh] $1" >> "$DEBUG_LOG"
}

# Initialize debug log
debug_log "=== STARTING claude-terminal.sh ==="
debug_log "Script arguments: $*"
debug_log "Working directory: $(pwd)"
debug_log "Script directory: $SCRIPT_DIR"

# Function to show usage help
show_usage() {
    echo "Claude Desktop Terminal - Main Launcher"
    echo
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "  --new, -n         Start a new chat directly"
    echo "  --recents, -r     Browse recent conversations"
    echo "  --continue, -c    Continue the last conversation"
    echo "  --menu, -m        Show interactive menu (default)"
    echo "  --help, -h        Show this help message"
    echo
    echo "If no option is provided, the interactive menu will be shown."
}

# Change to script directory
cd "$SCRIPT_DIR"

# Parse command line arguments
debug_log "Parsing command line argument: '${1:-}'"

case "${1:-}" in
    --new|-n)
        debug_log "Selected: New chat"
        echo "Starting new chat..."
        debug_log "About to run: claude"
        debug_log "Current directory: $(pwd)"
        debug_log "Claude command location: $(which claude 2>/dev/null || echo 'NOT FOUND')"

        if ! claude; then
            debug_log "Claude command failed with exit code: $?"
            echo
            echo "Failed to start Claude. Please check your installation and try again."
            debug_log "Exiting with error code 1"
            exit 1
        else
            debug_log "Claude command completed successfully"
        fi
        ;;
    --recents|-r)
        debug_log "Selected: Recent conversations"
        echo "Loading recent conversations..."
        debug_log "About to run: $SCRIPT_DIR/claude-recents.sh"
        "$SCRIPT_DIR/claude-recents.sh"
        debug_log "claude-recents.sh completed"
        ;;
    --continue|-c)
        debug_log "Selected: Continue last conversation"
        echo "Continuing last conversation..."
        debug_log "About to run: claude --continue"

        if ! claude --continue; then
            debug_log "Claude --continue failed with exit code: $?"
            echo
            echo "Failed to continue conversation. You may not have any previous conversations."
            debug_log "Exiting with error code 1"
            exit 1
        else
            debug_log "Claude --continue completed successfully"
        fi
        ;;
    --menu|-m|"")
        debug_log "Selected: Show menu (default)"
        debug_log "About to run: $SCRIPT_DIR/claude-menu.sh"
        if "$SCRIPT_DIR/claude-menu.sh"; then
            debug_log "claude-menu.sh completed successfully"
        else
            menu_exit_code=$?
            debug_log "claude-menu.sh exited with code: $menu_exit_code"
            if [ $menu_exit_code -eq 130 ]; then
                debug_log "User interrupted menu (Ctrl+C)"
            fi
        fi
        ;;
    --help|-h)
        debug_log "Selected: Help"
        show_usage
        debug_log "Exiting with code 0 (help)"
        exit 0
        ;;
    *)
        debug_log "Selected: Unknown option '$1'"
        echo "Error: Unknown option '$1'"
        echo
        show_usage
        debug_log "Exiting with error code 1 (unknown option)"
        exit 1
        ;;
esac

debug_log "=== ENDING claude-terminal.sh ==="