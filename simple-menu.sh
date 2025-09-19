#!/bin/bash

# Simple menu without complex error handling
cd /home/doug/Code/claude-desktop

clear
echo "🤖 Claude Desktop Terminal"
echo "========================="
echo
echo "1) New Chat"
echo "2) Recent Conversations"
echo "3) Continue Last"
echo "4) Exit"
echo

read -p "Select option (1-4): " choice

case $choice in
    1)
        echo "Starting new chat..."
        exec claude
        ;;
    2)
        echo "Loading recent conversations..."
        exec claude -r
        ;;
    3)
        echo "Continuing last conversation..."
        exec claude -c
        ;;
    4)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac