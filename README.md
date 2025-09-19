```
 ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
██║     ██║     ███████║██║   ██║██║  ██║█████╗
██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝
╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗

████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗
╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║
   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║
   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║
   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗
   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
```

<p align="center">
  <em>🤖 A beautiful terminal-based replacement for Claude Desktop</em><br>
  <em>Interactive menus • Recent conversations • Persistent workflow</em>
</p>

![Claude Terminal Demo](https://img.shields.io/badge/Claude-Terminal-blue?style=for-the-badge&logo=anthropic)
![Status](https://img.shields.io/badge/Status-Working-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

## ✨ Features

- 🎯 **Interactive Menu** - Beautiful fzf-powered interface with emojis and colors
- 💬 **New Conversations** - Start fresh Claude chats instantly
- 📋 **Recent Conversations** - Browse and resume previous conversations
- ⏮️ **Continue Last** - Quickly resume your most recent conversation
- 🔄 **Persistent Menu** - Return to menu after conversations end
- ⚡ **Command Line Interface** - Direct access for power users
- 🎨 **Beautiful Design** - Colorful terminal UI with professional styling
- 🛡️ **Reliable** - Simple architecture without complex error handling

## 🚀 Quick Start

### Prerequisites

- [Claude CLI](https://claude.ai/code) installed and configured
- `bash` shell
- `fzf` (optional, for enhanced menu experience)

### Installation

```bash
git clone https://github.com/Kiwi-Tech-Lab-DNA/claude-terminal.git
cd claude-terminal
chmod +x *.sh
```

### Usage

**Interactive Menu (Recommended):**
```bash
./claude-terminal.sh
```

**Direct Commands:**
```bash
./claude-terminal.sh --new      # Start new chat
./claude-terminal.sh --recents  # Browse recent conversations
./claude-terminal.sh --continue # Continue last conversation
./claude-terminal.sh --help     # Show help
```

## 📱 Interface

### Main Menu
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                     🤖 Claude Desktop Terminal
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🆕 New Chat
📋 Recent Conversations
⏮️  Continue Last Conversation
❓ Help
❌ Exit
```

### Workflow
1. **Select Option** → Choose from the interactive menu
2. **Have Conversation** → Use Claude normally
3. **Exit Claude** → Press `Ctrl+D` when done
4. **Return to Menu** → Press Enter to return to main menu
5. **Repeat** → Select another option or exit

## 🎯 Why Claude Terminal?

### **Advantages over Claude Desktop:**
- ✅ **Faster startup** - No Electron overhead
- ✅ **Keyboard-driven** - Navigate entirely with keyboard
- ✅ **Persistent workflow** - Menu stays open between conversations
- ✅ **Terminal native** - Integrates perfectly with terminal workflows
- ✅ **Lightweight** - Minimal resource usage
- ✅ **Customizable** - Easy to modify and extend

### **Perfect for:**
- Developers who live in the terminal
- Users who prefer keyboard navigation
- Anyone wanting a faster Claude experience
- Terminal enthusiasts and power users

## 🛠️ Technical Details

### Architecture
- `claude-terminal.sh` - Main launcher with command-line argument support
- `claude-menu.sh` - Interactive menu system with persistent loop
- `claude-recents.sh` - Recent conversations browser using `claude -r`
- `CLAUDE.md` - Development documentation for Claude Code

### Dependencies
- **Required:** `claude` CLI, `bash`
- **Optional:** `fzf` (for enhanced menu experience)

### Error Handling
- Graceful fallback when `fzf` is unavailable
- Simple, reliable architecture
- User-friendly error messages
- No complex error handling that interferes with Claude

## 📖 Documentation

- [CLAUDE.md](CLAUDE.md) - Comprehensive development documentation
- [Command Reference](#usage) - All available commands and options
- [Troubleshooting](#troubleshooting) - Common issues and solutions

## 🔧 Development

### Adding Features
The codebase is designed for easy extension:

```bash
# Test individual components
./simple-menu.sh      # Basic menu without fzf
./test-claude.sh      # Test Claude CLI integration
./simple-launcher.sh  # Minimal launcher
```

### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 🐛 Troubleshooting

### Common Issues

**Menu closes immediately:**
- Ensure Claude CLI is properly installed
- Check that you have terminal permissions
- Try the simple launcher: `./simple-launcher.sh`

**fzf not working:**
- Install fzf: `brew install fzf` (macOS) or `apt install fzf` (Ubuntu)
- The menu will fall back to basic selection without fzf

**Claude command not found:**
- Install Claude CLI from [claude.ai/code](https://claude.ai/code)
- Ensure it's in your PATH: `which claude`

## 📝 License

MIT License - feel free to use, modify, and distribute!

## 🙏 Acknowledgments

- [Anthropic](https://anthropic.com) for Claude and Claude Code
- [fzf](https://github.com/junegunn/fzf) for the fantastic fuzzy finder
- The terminal community for inspiration

---

**⭐ Star this repo if you find it useful!**

Made with ❤️ for the terminal community