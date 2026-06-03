# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Apply Changes

**macOS (nix-darwin):**
```bash
darwin-rebuild switch --flake ~/DotFiles/system
```
`nix-output-monitor` が入っているので `nom` でラップすると出力が見やすい:
```bash
darwin-rebuild switch --flake ~/DotFiles/system |& nom
```

**Windows:**
```powershell
.\setup-windows.ps1
```

## Architecture

設定ファイル本体はリポジトリルートに置き、各 OS のツールがそこへリンクを張る構造。

```
DotFiles/
├── nvim/            # LazyVim ベースの Neovim 設定（Windows/macOS 共用）
├── wezterm/         # WezTerm 設定（Windows/macOS 共用）
├── starship.toml    # Starship 設定（Windows/macOS 共用）
├── fonts/moralerspace/  # カスタムフォントの Nix derivation
├── setup-windows.ps1    # Windows: Scoop/Winget インストール + シンボリックリンク
└── system/              # Nix 設定（macOS、将来 Linux も）
    ├── flake.nix
    ├── flake.lock
    └── darwin/
        ├── _common/
        │   ├── system.nix       # nix-darwin 共通設定（Homebrew casks、macOS defaults）
        │   └── home/
        │       ├── default.nix  # home-manager エントリポイント
        │       ├── packages.nix # home.packages
        │       └── programs/    # 各ツールの設定モジュール
        └── <hostname>/
            ├── system.nix       # マシン固有の nix-darwin 設定
            └── home.nix         # マシン固有の home-manager 設定
```

### 重要な設計上の決定

**`df-root`**: `system/flake.nix` からリポジトリルートへの参照。`fonts/moralerspace` など `system/` 外のファイルを Nix で参照するために使う。

**`mkOutOfStoreSymlink`**: `nvim/`, `wezterm/`, `starship.toml` のリンクに使用。通常の `home.file` は Nix ストア経由のコピーになり read-only になるため、`lazy-lock.json` などの書き換えが必要なファイルが壊れる。`mkOutOfStoreSymlink` はリポジトリへの直接シンボリックリンクを作るのでこの問題を回避できる。

**CLI ツールは Nix、GUI アプリは Homebrew casks**: `system.nix` に casks、`packages.nix` に CLI ツールと分離している。

## 新しいマシンを追加する

1. `system/darwin/<hostname>/system.nix` を作成
2. `system/darwin/<hostname>/home.nix` を作成
3. `system/flake.nix` の outputs に追加:
```nix
darwinConfigurations.<hostname> = mkDarwinSystem {
  hostname = "<hostname>";
  username = "<username>";
};
```

## 新しいプログラムを追加する

- **パッケージのみ**: `system/darwin/_common/home/packages.nix` の `home.packages` に追加
- **home-manager モジュールがある場合**: `system/darwin/_common/home/programs/<name>.nix` を作成し、`default.nix` の `imports` に追加
- **GUI アプリ**: `system/darwin/_common/system.nix` の `homebrew.casks` に追加

## テーマ

全ツールで **Catppuccin Frappe** に統一している。新しいツールを追加する際もこのテーマに合わせる。
