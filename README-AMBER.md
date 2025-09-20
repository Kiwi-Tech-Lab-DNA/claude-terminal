# 🤖 Claude Terminal - Amber Edition

This is the **Amber rewrite** of Claude Terminal - a beautiful terminal-based replacement for Claude Desktop with improved code readability and maintainability.

## 🔥 Why Amber?

The original bash version was functional but verbose. This Amber rewrite provides:

- ✅ **50% less code** - Much more concise and readable
- ✅ **Type safety** - Catches errors at compile time
- ✅ **Modern syntax** - Closer to natural language
- ✅ **Better maintainability** - Easier to extend and modify
- ✅ **Same functionality** - Compiles to identical bash scripts
- ✅ **Zero runtime dependencies** - Still just bash after compilation

## 🛠️ Building from Source

### Prerequisites

1. **Install Amber:**
```bash
curl -s https://raw.githubusercontent.com/Ph0enixKM/Amber/main/setup/install.sh | bash
```

2. **Verify installation:**
```bash
amber --version
```

### Build Process

```bash
# Clone the repository
git clone https://github.com/Kiwi-Tech-Lab-DNA/claude-terminal.git
cd claude-terminal

# Switch to amber branch
git checkout amber-rewrite

# Build the project
./build.sh
```

This creates compiled bash scripts in the `build/` directory.

## 📂 Project Structure

```
claude-terminal/
├── src/                     # Amber source files
│   ├── claude-terminal.ab   # Main launcher (30 lines vs 60 bash)
│   ├── claude-menu.ab       # Interactive menu (80 lines vs 150 bash)
│   └── claude-recents.ab    # Recent conversations (90 lines vs 180 bash)
├── build/                   # Compiled bash scripts
│   ├── claude-terminal.sh
│   ├── claude-menu.sh
│   └── claude-recents.sh
└── build.sh                 # Build script
```

## 🎯 Code Comparison

### Before (Bash):
```bash
# Parse command line arguments
case "${1:-}" in
    --new|-n)
        echo "Starting new chat..."
        cd "$SCRIPT_DIR"
        exec claude
        ;;
    --recents|-r)
        echo "Loading recent conversations..."
        exec "$SCRIPT_DIR/claude-recents.sh"
        ;;
    # ... 40 more lines
esac
```

### After (Amber):
```amber
// Much cleaner argument handling
let arg = if len(args) > 0 { args[0] } else { "" }

if arg == "--new" or arg == "-n" {
    echo "Starting new chat..."
    $claude$?
} else if arg == "--recents" or arg == "-r" {
    echo "Loading recent conversations..."
    $"{script_dir}/claude-recents.sh"$?
}
```

## 🚀 Usage

After building, use exactly like the bash version:

```bash
# Interactive menu
./build/claude-terminal.sh

# Direct commands
./build/claude-terminal.sh --new
./build/claude-terminal.sh --recents
./build/claude-terminal.sh --continue
```

## 🔧 Development

### Adding Features

The Amber code is much easier to extend:

```amber
// Adding a new menu option is simple
if choice == "🔧 Settings" {
    show_settings_menu()
} else if choice == "📊 Statistics" {
    show_stats()
}
```

### Building for Distribution

```bash
# Build optimized version
./build.sh

# The compiled bash scripts are ready for distribution
cp build/*.sh /usr/local/bin/
```

## 📈 Benefits

| Metric | Bash Version | Amber Version | Improvement |
|--------|--------------|---------------|-------------|
| Lines of Code | ~400 | ~200 | 50% reduction |
| Readability | Complex | Natural | Much better |
| Maintainability | Difficult | Easy | Significantly improved |
| Type Safety | None | Compile-time | Error prevention |
| Runtime | Same | Same | No overhead |

## 🤝 Contributing

The Amber version is much more contributor-friendly:

1. **Fork the repository**
2. **Edit .ab files** in `src/` directory
3. **Run `./build.sh`** to compile
4. **Test the compiled scripts**
5. **Submit a pull request**

## 📝 Migration Guide

### From Bash to Amber Development

If you want to contribute to the Amber version:

1. **Learn Amber basics:** [Amber Documentation](https://amber-lang.com/)
2. **Edit source files:** Modify `.ab` files in `src/`
3. **Compile changes:** Run `./build.sh`
4. **Test compiled output:** Use scripts from `build/`

### Staying with Bash

The original bash version remains available on the `main` branch:

```bash
git checkout main  # Switch to bash version
```

---

**⭐ This Amber rewrite demonstrates how modern languages can make shell scripting more maintainable while preserving all the benefits of bash compatibility!**