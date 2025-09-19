#!/bin/bash

# Claude Desktop Replacement - Main Launcher
# This script provides multiple ways to access Claude functionality

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
case "${1:-}" in
    --new|-n)
        echo "Starting new chat..."
        exec claude
        ;;
    --recents|-r)
        echo "Loading recent conversations..."
        exec "$SCRIPT_DIR/claude-recents.sh"
        ;;
    --continue|-c)
        echo "Continuing last conversation..."
        exec claude --continue
        ;;
    --menu|-m|"")
        # Default behavior - show menu
        exec "$SCRIPT_DIR/claude-menu.sh"
        ;;
    --help|-h)
        show_usage
        exit 0
        ;;
    *)
        echo "Error: Unknown option '$1'"
        echo
        show_usage
        exit 1
        ;;
esac