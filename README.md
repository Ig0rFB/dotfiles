# Dotfiles

This repository contains my personal configuration files (dotfiles), managed and synchronized via a custom setup script.

## Structure

- `nvim/`: Neovim configuration (`.lua` files only).
- `ghostty/`: Ghostty terminal configuration.
- `install.sh`: The main management script.

## How it works

The `install.sh` script performs the following actions:

1.  **Migration**: If the config files exist in their default system locations but not in this folder, it moves them here.
2.  **Symlinking**: It creates symbolic links from this directory back to the expected system locations (e.g., `~/.config/nvim`).
3.  **Backup**: If a real file exists where a symlink should be, it creates a `.bak` copy before linking.
4.  **Git Sync**: It automatically detects changes, commits them with a timestamped message, and attempts to push to GitHub.

## Usage

To sync your current changes or set up a new machine:

```bash
./install.sh
```

## Setup on a New Machine

1. Clone this repository to `~/dotfiles`.
2. Run `./install.sh`.
