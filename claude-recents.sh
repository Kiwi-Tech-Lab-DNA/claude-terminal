#!/bin/bash

# Claude Desktop Replacement - Recent Conversations
# This script provides an interface for browsing and resuming recent Claude conversations

set -e

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to display header
show_header() {
    clear
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}                      📋 Recent Conversations${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
}

# Function to show recent conversations using fzf
show_recents_fzf() {
    local temp_file
    temp_file=$(mktemp)

    # Create a temporary script to capture the output of claude -r
    cat > "$temp_file" << 'EOF'
#!/bin/bash
# Capture the interactive session ID selection
exec 3>&1
claude -r 2>&1 | tee /dev/fd/3
EOF

    chmod +x "$temp_file"

    echo -e "${YELLOW}Loading recent conversations...${NC}"
    echo
    echo "This will show Claude's built-in conversation selector."
    echo "Use it to choose which conversation to resume."
    echo
    echo -e "${GREEN}Press Enter to continue, or Ctrl+C to cancel...${NC}"
    read -r

    cd "$SCRIPT_DIR"

    # Use claude's built-in resume functionality
    exec claude -r

    # Cleanup
    rm -f "$temp_file"
}

# Function to show recent conversations with basic interface
show_recents_basic() {
    echo -e "${YELLOW}Recent Conversations${NC}"
    echo
    echo "This will launch Claude's built-in conversation browser."
    echo "You can browse and select from your recent conversations."
    echo
    echo -e "${GREEN}Options:${NC}"
    echo "  1) Browse recent conversations (claude -r)"
    echo "  2) Continue last conversation (claude -c)"
    echo "  3) Return to main menu"
    echo

    read -p "Select an option (1-3): " choice

    case $choice in
        1)
            echo -e "${GREEN}Loading conversation browser...${NC}"
            cd "$SCRIPT_DIR"
            exec claude -r
            ;;
        2)
            echo -e "${GREEN}Continuing last conversation...${NC}"
            cd "$SCRIPT_DIR"
            exec claude -c
            ;;
        3)
            exec "$SCRIPT_DIR/claude-menu.sh"
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            sleep 1
            show_recents_basic
            ;;
    esac
}

# Function to handle errors gracefully
handle_error() {
    echo -e "${RED}Error: Failed to load recent conversations.${NC}"
    echo
    echo "This might happen if:"
    echo "  • You haven't had any conversations with Claude yet"
    echo "  • Claude CLI is not properly configured"
    echo "  • There's a connectivity issue"
    echo
    echo -e "${YELLOW}Would you like to:${NC}"
    echo "  1) Try again"
    echo "  2) Start a new conversation instead"
    echo "  3) Return to main menu"
    echo

    read -p "Select an option (1-3): " choice

    case $choice in
        1)
            main_recents
            ;;
        2)
            cd "$SCRIPT_DIR"
            exec claude
            ;;
        3)
            exec "$SCRIPT_DIR/claude-menu.sh"
            ;;
        *)
            echo -e "${RED}Invalid option.${NC}"
            sleep 1
            handle_error
            ;;
    esac
}

# Main function
main_recents() {
    show_header

    # Check if claude command is available
    if ! command -v claude &> /dev/null; then
        echo -e "${RED}Error: Claude CLI not found.${NC}"
        echo "Please make sure Claude CLI is installed and available in your PATH."
        echo
        echo "Press Enter to return to main menu..."
        read -r
        exec "$SCRIPT_DIR/claude-menu.sh"
    fi

    # Try to use the interface
    if command -v fzf &> /dev/null; then
        show_recents_fzf || handle_error
    else
        show_recents_basic || handle_error
    fi
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h    Show this help message"
        echo
        echo "This script provides an interface for browsing and resuming"
        echo "recent Claude conversations using the claude -r command."
        exit 0
        ;;
    *)
        main_recents
        ;;
esac