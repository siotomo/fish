#!/bin/bash

# Fish shell dotfiles bootstrap script
# fish_pluginsのシンボリックリンクを作成し、fisherをインストール

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🐟 Fish shell configuration setup..."

# ~/.config/fishディレクトリが存在しない場合は作成
if [ ! -d "$CONFIG_DIR/fish" ]; then
    echo "Creating ~/.config/fish directory..."
    mkdir -p "$CONFIG_DIR/fish"
fi

# fish_pluginsのリンクを作成（fisherインストール前に作成することで内容を保護）
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

# fisherがインストールされているかチェック
echo ""
echo "Checking fisher installation..."
if fish -c "type -q fisher" 2>/dev/null; then
    echo "✓ fisher is already installed"
else
    echo "Installing fisher..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
    echo "✓ fisher installed"
fi

# fish_pluginsファイルに下記4つの内容がなければ追記
FISH_PLUGINS_LIST=(
    "jorgebucaran/fisher"
    "jethrokuan/z"
    "oh-my-fish/plugin-peco"
    "ilancosman/tide@v6"
)
FISH_PLUGINS_PATH="$SCRIPT_DIR/fish_plugins"

for plugin in "${FISH_PLUGINS_LIST[@]}"; do
    if ! grep -Fxq "$plugin" "$FISH_PLUGINS_PATH"; then
        echo "$plugin" >> "$FISH_PLUGINS_PATH"
        echo "Added $plugin to fish_plugins"
    fi
done

# プラグインをインストール
echo ""
echo "Installing plugins..."
fish -c "fisher update"
echo "✓ Plugins installed"

# Tide プロンプトの初期設定
echo ""
echo "Configuring Tide prompt..."
fish -c "./tide_configure.sh"
echo "✓ Tide prompt configured"
echo ""
echo "✨ Setup complete!"
