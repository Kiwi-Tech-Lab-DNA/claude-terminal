# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project is a replacement for Claude Desktop, designed to provide a streamlined terminal-based interface for interacting with Claude Code.

## Architecture

The project consists of a minimal setup with a launcher script that opens Claude Code directly in this directory:

- `claude-terminal.sh`: Main launcher script that changes to the project directory and executes the `claude` command
- This is a terminal-based workflow where the claude-terminal.sh script serves as the entry point to launch Claude Code

## Development Commands

Since this is a script-based project without package.json or build system:

- **Launch Claude Code**: `./claude-terminal.sh` - Opens Claude Code in this directory
- **Direct execution**: `cd /home/doug/Code/claude-desktop && claude` - Manual way to start Claude Code

## Usage

The primary workflow is to run the launcher script to enter Claude Code for any development or assistance needs in this repository.