#!/bin/bash

# Claude Desktop Replacement - Interactive Menu
# This script provides an interactive menu for accessing Claude features

# Error handling function
error_handler() {
    local line_no=$1
    local error_code=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [claude-menu.sh] ERROR: Script failed at line $line_no with exit code $error_code" >> "$SCRIPT_DIR/debug.log" 2>/dev/null || true
    echo "Script error occurred. Check debug.log for details."
    exit $error_code
}

# Set up error handling
trap 'error_handler ${LINENO} $?' ERR
set -e

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Debug logging
DEBUG_LOG="$SCRIPT_DIR/debug.log"

# Function to log debug messages
debug_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [claude-menu.sh] $1" >> "$DEBUG_LOG"
}

# Initialize debug log
debug_log "=== STARTING claude-menu.sh ==="
debug_log "Working directory: $(pwd)"
debug_log "Script directory: $SCRIPT_DIR"

# Function to display menu header
show_header() {
    clear
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}                     🤖 Claude Desktop Terminal${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
}

# Function to show menu using fzf if available
show_menu_fzf() {
    local choice
    debug_log "Starting fzf menu selection"

    # Temporarily disable exit on error for fzf
    set +e
    choice=$(echo -e "🆕 New Chat\n📋 Recent Conversations\n⏮️  Continue Last Conversation\n❓ Help\n❌ Exit" | \
             fzf --height=10 --layout=reverse --border=rounded \
                 --prompt="Select an option: " \
                 --header="What would you like to do?" \
                 --ansi 2>/dev/null)
    local fzf_exit_code=$?
    set -e

    debug_log "fzf exit code: $fzf_exit_code"
    debug_log "fzf choice: '$choice'"

    # Handle fzf cancellation
    if [ $fzf_exit_code -ne 0 ]; then
        debug_log "fzf was cancelled or failed"
        return 0  # User cancelled
    fi

    case "$choice" in
        "🆕 New Chat")
            debug_log "fzf selected: New Chat"
            return 1
            ;;
        "📋 Recent Conversations")
            debug_log "fzf selected: Recent Conversations"
            return 2
            ;;
        "⏮️  Continue Last Conversation")
            debug_log "fzf selected: Continue Last Conversation"
            return 3
            ;;
        "❓ Help")
            debug_log "fzf selected: Help"
            return 4
            ;;
        "❌ Exit")
            debug_log "fzf selected: Exit"
            return 5
            ;;
        *)
            debug_log "fzf selected: Unknown choice '$choice'"
            return 0
            ;;
    esac
}

# Function to show menu using basic select
show_menu_basic() {
    echo -e "${YELLOW}What would you like to do?${NC}"
    echo
    PS3=$'\n'"Please select an option (1-5): "
    local options=("New Chat" "Recent Conversations" "Continue Last Conversation" "Help" "Exit")
    select opt in "${options[@]}"
    do
        case $REPLY in
            1) return 1 ;;
            2) return 2 ;;
            3) return 3 ;;
            4) return 4 ;;
            5) return 5 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Function to show help
show_help() {
    echo -e "${GREEN}Claude Desktop Terminal - Help${NC}"
    echo
    echo "This is a terminal-based interface for Claude that emulates Claude Desktop features."
    echo
    echo -e "${YELLOW}Menu Options:${NC}"
    echo "  • New Chat              - Start a fresh conversation with Claude"
    echo "  • Recent Conversations  - Browse and resume previous conversations"
    echo "  • Continue Last        - Quickly continue your most recent conversation"
    echo
    echo -e "${YELLOW}Command Line Usage:${NC}"
    echo "  ./claude-terminal.sh             - Show interactive menu (default)"
    echo "  ./claude-terminal.sh --new        - Start a new chat directly"
    echo "  ./claude-terminal.sh --recents    - Show recent conversations"
    echo "  ./claude-terminal.sh --continue   - Continue last conversation"
    echo
    echo -e "${YELLOW}Keyboard Shortcuts:${NC}"
    echo "  • Use arrow keys or numbers to navigate the menu"
    echo "  • Press Enter to select an option"
    echo "  • Press Ctrl+C to exit at any time"
    echo
    echo "Press Enter to return to the main menu..."
    read -r
}

# Main menu loop
main_menu() {
    debug_log "Entering main menu loop"

    while true; do
        debug_log "Showing menu header"
        show_header

        debug_log "Checking for fzf availability"
        # Check if fzf is available
        if command -v fzf &> /dev/null; then
            debug_log "Using fzf menu"
            show_menu_fzf
        else
            debug_log "Using basic menu"
            show_menu_basic
        fi

        choice=$?
        debug_log "User selected choice: $choice"

        case $choice in
            1)
                debug_log "Processing: New chat"
                echo -e "${GREEN}Starting new chat...${NC}"
                cd "$SCRIPT_DIR"
                debug_log "About to run claude command"
                debug_log "Current directory: $(pwd)"
                debug_log "Claude command location: $(which claude 2>/dev/null || echo 'NOT FOUND')"

                # Temporarily disable exit-on-error for claude command
                set +e
                claude
                claude_exit_code=$?
                set -e

                debug_log "Claude command exit code: $claude_exit_code"

                if [ $claude_exit_code -ne 0 ]; then
                    debug_log "Claude command failed with exit code: $claude_exit_code"
                    echo
                    echo -e "${RED}Failed to start Claude (exit code: $claude_exit_code). Press Enter to return to menu...${NC}"
                    read -r
                    debug_log "User pressed Enter, returning to menu"
                else
                    debug_log "Claude command completed successfully"
                fi
                ;;
            2)
                debug_log "Processing: Recent conversations"
                echo -e "${GREEN}Loading recent conversations...${NC}"
                debug_log "About to run: $SCRIPT_DIR/claude-recents.sh"
                "$SCRIPT_DIR/claude-recents.sh"
                debug_log "claude-recents.sh completed"
                ;;
            3)
                debug_log "Processing: Continue last conversation"
                echo -e "${GREEN}Continuing last conversation...${NC}"
                cd "$SCRIPT_DIR"
                debug_log "About to run: claude --continue"

                # Temporarily disable exit-on-error for claude command
                set +e
                claude --continue
                claude_exit_code=$?
                set -e

                debug_log "Claude --continue exit code: $claude_exit_code"

                if [ $claude_exit_code -ne 0 ]; then
                    debug_log "Claude --continue failed with exit code: $claude_exit_code"
                    echo
                    echo -e "${RED}Failed to continue conversation (exit code: $claude_exit_code). Press Enter to return to menu...${NC}"
                    read -r
                    debug_log "User pressed Enter, returning to menu"
                else
                    debug_log "Claude --continue completed successfully"
                fi
                ;;
            4)
                debug_log "Processing: Help"
                show_help
                ;;
            5)
                debug_log "Processing: Exit"
                echo -e "${GREEN}Goodbye!${NC}"
                debug_log "User chose to exit"
                exit 0
                ;;
            0)
                debug_log "Processing: User cancelled"
                # User cancelled selection
                echo -e "${YELLOW}Cancelled${NC}"
                debug_log "User cancelled, exiting"
                exit 0
                ;;
        esac

        debug_log "Completed choice processing, returning to menu loop"
    done
}

# Run the main menu
debug_log "About to call main_menu function"
main_menu
debug_log "=== ENDING claude-menu.sh ==="