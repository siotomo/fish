#!/bin/bash

# Fish shell dotfiles bootstrap script
# fish_pluginsのシンボリックリンクを作成

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🐟 Fish shell configuration setup..."

# ~/.config/fishディレクトリが存在しない場合は作成
if [ ! -d "$CONFIG_DIR/fish" ]; then
    echo "Creating ~/.config/fish directory..."
    mkdir -p "$CONFIG_DIR/fish"
fi

# fish_pluginsのリンクを作成
if [ -L "$CONFIG_DIR/fish/fish_plugins" ]; then
    echo "✓ fish_plugins symlink already exists"
elif [ -f "$CONFIG_DIR/fish/fish_plugins" ]; then
    echo "⚠️  fish_plugins exists as a regular file. Backing up..."
    mv "$CONFIG_DIR/fish/fish_plugins" "$CONFIG_DIR/fish/fish_plugins.backup"
    ln -s "$SCRIPT_DIR/fish_plugins" "$CONFIG_DIR/fish/fish_plugins"
    echo "✓ fish_plugins symlink created (backup saved)"
else
    ln -s "$SCRIPT_DIR/fish_plugins" "$CONFIG_DIR/fish/fish_plugins"
    echo "✓ fish_plugins symlink created"
fi

echo ""
echo "✨ Setup complete!"
