#!/bin/bash

# Claude Desktop Replacement - Interactive Menu
# This script provides an interactive menu for accessing Claude features

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    choice=$(echo -e "🆕 New Chat\n📋 Recent Conversations\n⏮️  Continue Last Conversation\n❓ Help\n❌ Exit" | \
             fzf --height=10 --layout=reverse --border=rounded \
                 --prompt="Select an option: " \
                 --header="What would you like to do?" \
                 --ansi 2>/dev/null) || return 0

    case "$choice" in
        "🆕 New Chat")
            return 1
            ;;
        "📋 Recent Conversations")
            return 2
            ;;
        "⏮️  Continue Last Conversation")
            return 3
            ;;
        "❓ Help")
            return 4
            ;;
        "❌ Exit")
            return 5
            ;;
        *)
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
    show_header

    # Check if fzf is available
    if command -v fzf &> /dev/null; then
        show_menu_fzf
    else
        show_menu_basic
    fi

    choice=$?

    case $choice in
        1)
            echo -e "${GREEN}Starting new chat...${NC}"
            cd "$SCRIPT_DIR"
            exec claude
            ;;
        2)
            echo -e "${GREEN}Loading recent conversations...${NC}"
            exec "$SCRIPT_DIR/claude-recents.sh"
            ;;
        3)
            echo -e "${GREEN}Continuing last conversation...${NC}"
            cd "$SCRIPT_DIR"
            exec claude --continue
            ;;
        4)
            show_help
            main_menu  # Return to menu after help
            ;;
        5)
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        0|*)
            echo -e "${YELLOW}Cancelled${NC}"
            exit 0
            ;;
    esac
}

# Run the main menu
main_menu