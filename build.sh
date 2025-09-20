#!/bin/bash

# Build script for Claude Terminal Amber version
# Compiles .ab files to bash scripts

set -e

echo "🔨 Building Claude Terminal from Amber sources..."

# Check if amber is installed
if ! command -v amber &> /dev/null; then
    echo "❌ Amber not found. Please install Amber first:"
    echo "   curl -s https://raw.githubusercontent.com/Ph0enixKM/Amber/main/setup/install.sh | bash"
    echo "   Or visit: https://github.com/Ph0enixKM/Amber"
    exit 1
fi

# Create build directory
mkdir -p build

# Compile Amber files to bash
echo "📝 Compiling claude-terminal.ab..."
amber build src/claude-terminal.ab build/claude-terminal.sh

echo "📝 Compiling claude-menu.ab..."
amber build src/claude-menu.ab build/claude-menu.sh

echo "📝 Compiling claude-recents.ab..."
amber build src/claude-recents.ab build/claude-recents.sh

# Make scripts executable
chmod +x build/*.sh

echo "✅ Build complete!"
echo "📂 Compiled scripts are in the 'build/' directory"
echo ""
echo "🚀 To run:"
echo "   ./build/claude-terminal.sh"
echo ""
echo "📦 To install system-wide:"
echo "   sudo cp build/*.sh /usr/local/bin/"