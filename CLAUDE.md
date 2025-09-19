# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project is a replacement for Claude Desktop, designed to provide a streamlined terminal-based interface for interacting with Claude Code. It includes a "Recents" feature that emulates Claude Desktop's conversation history functionality.

## Architecture

The project consists of multiple scripts that work together to provide a complete Claude interface:

- `claude-terminal.sh`: Main launcher script with command-line argument support
- `claude-menu.sh`: Interactive menu system with colorful interface using fzf when available
- `claude-recents.sh`: Handles browsing and resuming recent conversations using `claude -r`
- All scripts are designed to work with the Claude CLI's built-in functionality

## Key Features

- **Interactive Menu**: Beautiful terminal-based menu with emoji icons and colors
- **Recent Conversations**: Browse and resume previous Claude conversations
- **Command Line Interface**: Direct access to features via command-line flags
- **Fallback Support**: Gracefully handles missing dependencies (fzf, etc.)
- **Error Handling**: Comprehensive error handling and user guidance

## Development Commands

### Primary Usage
- **Interactive Menu**: `./claude-terminal.sh` - Shows the main menu (default behavior)
- **New Chat**: `./claude-terminal.sh --new` or `./claude-terminal.sh -n`
- **Recent Conversations**: `./claude-terminal.sh --recents` or `./claude-terminal.sh -r`
- **Continue Last**: `./claude-terminal.sh --continue` or `./claude-terminal.sh -c`
- **Show Menu**: `./claude-terminal.sh --menu` or `./claude-terminal.sh -m`
- **Help**: `./claude-terminal.sh --help` or `./claude-terminal.sh -h`

### Direct Script Access
- **Menu Only**: `./claude-menu.sh`
- **Recents Only**: `./claude-recents.sh`

### Git Commands
- **Check Status**: `git status`
- **View History**: `git log --oneline`
- **Make Changes**: Standard git workflow for any modifications

## Dependencies

### Required
- `claude` CLI tool (must be installed and configured)
- `bash` (for script execution)

### Optional (Enhanced Experience)
- `fzf` - Provides better interactive selection menus
- Terminal with color support for the best visual experience

## Usage Patterns

1. **First-time users**: Run `./claude-terminal.sh` to see the interactive menu
2. **Power users**: Use direct flags like `./claude-terminal.sh --recents` for quick access
3. **Recent conversations**: The recents feature leverages Claude CLI's built-in `claude -r` functionality
4. **Continuing work**: Use `--continue` to resume your last conversation quickly

## Error Handling

The scripts include comprehensive error handling for common issues:
- Missing Claude CLI installation
- No previous conversations
- Connectivity problems
- Missing optional dependencies

Users are guided through alternatives when errors occur.