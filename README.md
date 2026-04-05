# README

This repository contains my personal configuration files (dotfiles), managed and synchronized via a custom setup script.

## Structure

- `nvim/`: Neovim configuration (`.lua` files only).
- `ghostty/`: Ghostty terminal configuration.
- `install.sh`: The main management script.

## How it works

The `install.sh` script performs the following actions:

1.  **Bidirectional Syncing**:
    - **From System to Dotfiles**: Any new `.lua` files created in `~/.config/nvim` are automatically moved to this repository and symlinked back.
    - **From Dotfiles to System**: Any `.lua` files created directly in this repository are symlinked to `~/.config/nvim` so Neovim can use them.
2.  **Ghostty Support**: Manages your Ghostty terminal configuration in the same way.
3.  **Safety Backup**: If a real file exists where a symlink should be, it creates a `.bak` copy before linking.
4.  **Git Sync**: It automatically detects changes, commits them with a timestamped message, and pushes them to GitHub.

## Usage

To sync your current changes or set up a new machine:

```bash
./install.sh
```
