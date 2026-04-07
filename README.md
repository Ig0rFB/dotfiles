# README

This repository contains my personal configuration files (dotfiles), managed and synchronized via a custom setup script.

## Structure

- `nvim/`: Neovim configuration (`.lua` files only).
- `ghostty/`: Ghostty terminal configuration.
- `claude/`: Claude AI configuration (`CLAUDE.md`).
- `gemini/`: Gemini CLI configuration (`GEMINI.md`).
- `install.sh`: The main management script.

## How it works

The `install.sh` script performs the following actions:

1.  **Bidirectional Syncing**:
    - **From System to Dotfiles**: Any new configuration files created on your system (Neovim, Ghostty, Claude, Gemini) are automatically moved to this repository and symlinked back.
    - **From Dotfiles to System**: Any existing or new configuration files in this repository are symlinked to their respective system locations.
2.  **Safety Backup**: If a real file exists where a symlink should be, it creates a `.bak` copy before linking.
3.  **Git Sync**: It automatically detects changes, commits them with a timestamped message, and pushes them to GitHub.

## Usage

To sync your current changes to your dotfiles repository:

```bash
./install.sh
```

### Adding New Configurations

To add a new file or directory to the management script, update `install.sh` by:
1.  Defining the target path in the **Configuration** section.
2.  Adding a call to `setup_file_link "$SOURCE_PATH" "$DOTFILES_PATH"` in the main execution block.
