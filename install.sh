#!/bin/bash

# Configuration
DOTFILES_DIR="$HOME/dotfiles"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
GHOSTTY_CONFIG="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

echo "Setting up dotfiles..."

# Function to safely move and link a single file
# $1: Source path in home (e.g., ~/.config/nvim/init.lua)
# $2: Destination path in dotfiles (e.g., ~/dotfiles/nvim/init.lua)
setup_file_link() {
    local source_path="$1"
    local dotfiles_path="$2"

    # Ensure the parent directory in dotfiles exists
    mkdir -p "$(dirname "$dotfiles_path")"

    # 1. If the dotfiles version doesn't exist but the source does, move it there
    if [ ! -e "$dotfiles_path" ] && [ -f "$source_path" ] && [ ! -L "$source_path" ]; then
        echo "Moving existing $source_path to $dotfiles_path"
        mv "$source_path" "$dotfiles_path"
    fi

    # 2. If the source exists and is NOT a symlink, back it up
    if [ -f "$source_path" ] && [ ! -L "$source_path" ]; then
        echo "Backing up existing $source_path to $source_path.bak"
        mv "$source_path" "$source_path.bak"
    fi

    # 3. Create the symlink
    if [ -f "$dotfiles_path" ]; then
        echo "Linking $dotfiles_path -> $source_path"
        mkdir -p "$(dirname "$source_path")"
        ln -svf "$dotfiles_path" "$source_path"
    fi
}

# 1. Setup Neovim (Only .lua files)
# This now handles files created in BOTH directions
echo "Processing Neovim .lua files..."

# First, find all .lua files in the DOTFILES directory to ensure they are linked to the system
if [ -d "$DOTFILES_DIR/nvim" ]; then
    cd "$DOTFILES_DIR/nvim" || exit
    find . -name "*.lua" -type f | while read -r lua_file; do
        lua_file_clean="${lua_file#./}"
        setup_file_link "$NVIM_CONFIG_DIR/$lua_file_clean" "$DOTFILES_DIR/nvim/$lua_file_clean"
    done
fi

# Second, find any NEW .lua files in the SYSTEM config directory that aren't in dotfiles yet
if [ -d "$NVIM_CONFIG_DIR" ]; then
    cd "$NVIM_CONFIG_DIR" || exit
    find . -name "*.lua" -type f | while read -r lua_file; do
        lua_file_clean="${lua_file#./}"
        # Only process if it hasn't been handled (i.e., if dotfiles version doesn't exist)
        if [ ! -f "$DOTFILES_DIR/nvim/$lua_file_clean" ]; then
            setup_file_link "$NVIM_CONFIG_DIR/$lua_file_clean" "$DOTFILES_DIR/nvim/$lua_file_clean"
        fi
    done
fi

# 2. Setup Ghostty
if [ -f "$GHOSTTY_CONFIG" ] || [ -f "$DOTFILES_DIR/ghostty/config.ghostty" ]; then
    setup_file_link "$GHOSTTY_CONFIG" "$DOTFILES_DIR/ghostty/config.ghostty"
fi

# 3. Git Sync Function
sync_to_github() {
    echo "Checking for changes to sync to GitHub..."
    cd "$DOTFILES_DIR" || exit

    # Initialize git if not already a repo
    if [ ! -d ".git" ]; then
        echo "Initializing Git repository..."
        git init
    fi

    # Check for changes
    if [[ -n $(git status --porcelain) ]]; then
        echo "Changes detected. Committing..."
        git add .
        local current_time=$(date "+%Y-%m-%d %H:%M:%S")
        git commit -m "Dotfiles updated: $current_time"
        
        # Check if remote exists before pushing
        if git remote | grep -q 'origin'; then
            echo "Pushing to GitHub..."
            git push origin main
        else
            echo "Warning: No 'origin' remote found. Skipping push."
        fi
    else
        echo "No changes detected in dotfiles."
    fi
}

# Execute sync
sync_to_github

echo "Dotfiles setup complete!"
