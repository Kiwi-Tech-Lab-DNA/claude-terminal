#!/bin/bash

# Simple test script to debug claude execution
echo "Testing claude execution..."
echo "Current directory: $(pwd)"
echo "Claude location: $(which claude)"
echo "About to run claude..."

# Try to run claude
claude

echo "Claude finished with exit code: $?"
echo "Script ending..."