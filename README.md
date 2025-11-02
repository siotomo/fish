# Fish Shell Configuration

Fish shell のプラグイン設定。

## Setup

```bash
./bootstrap.sh
```

以下が自動で実行されます：
1. `fish_plugins` を `~/.config/fish/` にシンボリックリンク
2. `fisher` を自動インストール（未インストールの場合）
3. プラグインをインストール

## Tide プロンプトの初期設定
セットアップ後、Fishシェルで以下のコマンドを実行して、Tideの初期設定ウィザードを開始し、プロンプトの見た目を整えてください。

```fish
tide configure
```

ウィザードの指示に従ってお好みのスタイルを選べます。
