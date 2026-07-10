# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Apply Changes

**macOS (nix-darwin):**
```bash
nh darwin switch
```
`nh` が自動で nix-output-monitor を使って出力を整形する。dry-run 確認は `nh darwin switch --dry-run`。

**Windows:**
```powershell
.\setup-windows.ps1   # Scoop/Winget インストール + シンボリックリンク
.\setup-nvim.ps1      # Neovim (nvim-windows/) のリンクのみ
```

## Architecture

設定ファイル本体はリポジトリルートに置き、各 OS のツールがそこへリンクを張る構造。

```
DotFiles/
├── nvim-windows/        # Windows 専用 Neovim 設定（LazyVim ベース）
├── wezterm/             # WezTerm 設定（Windows/macOS 共用）
├── starship.toml        # Starship 設定（Windows/macOS 共用）
├── powershell/          # PowerShell プロファイル
├── fonts/moralerspace/  # カスタムフォントの Nix derivation
├── setup-windows.ps1
└── system/              # Nix 設定（macOS、将来 Linux も）
    ├── flake.nix
    ├── _common/
    │   └── home/programs/
    │       ├── neovim.nix   # NixVim 設定（macOS/Linux 共用）
    │       └── nh.nix
    └── darwin/
        ├── _common/
        │   ├── system.nix       # Homebrew casks、macOS defaults
        │   └── home/
        │       ├── default.nix  # home-manager エントリポイント
        │       ├── packages.nix # home.packages（CLI ツール）
        │       └── programs/    # darwin 固有: git, zsh, starship, wezterm 等
        └── <hostname>/
            ├── system.nix       # マシン固有の nix-darwin 設定
            └── home.nix         # マシン固有の home-manager 設定
```

### 重要な設計上の決定

**`system/_common/` vs `system/darwin/_common/`**: `_common/home/programs/` が2箇所ある。`system/_common/` は将来の Linux 共用を想定した設定（現在は neovim.nix のみ）。`system/darwin/_common/home/programs/` は macOS 固有のツール設定。

**`df-root`**: `system/flake.nix` からリポジトリルートへの参照。`fonts/moralerspace` など `system/` 外のファイルを Nix で参照するために使う。

**`mkOutOfStoreSymlink`**: `wezterm/`, `starship.toml` のリンクに使用。通常の `home.file` は Nix ストア経由のコピーになり read-only になるため、書き換えが必要なファイルが壊れる。`mkOutOfStoreSymlink` はリポジトリへの直接シンボリックリンクを作るのでこの問題を回避できる。

**CLI ツールは Nix、GUI アプリは Homebrew casks**: `darwin/_common/system.nix` に casks、`darwin/_common/home/packages.nix` に CLI ツールと分離している。

**macOS の Neovim は NixVim**: `nvim-windows/` (LazyVim) は Windows 専用。macOS は `system/_common/home/programs/neovim.nix` で宣言的に管理し、`mason` や `lazy-lock.json` は不要。

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
- **macOS 固有の home-manager モジュール**: `system/darwin/_common/home/programs/<name>.nix` を作成し、`default.nix` の `imports` に追加
- **macOS/Linux 共用の home-manager モジュール**: `system/_common/home/programs/<name>.nix` を作成し、`darwin/_common/home/default.nix` の `imports` に追加
- **GUI アプリ**: `system/darwin/_common/system.nix` の `homebrew.casks` に追加

## テーマ

全ツールで **Catppuccin Frappe** に統一している。新しいツールを追加する際もこのテーマに合わせる。

## WezTerm

リーダーキーは `Ctrl+,`。主なカスタムキーバインド:

| キー | 動作 |
|---|---|
| `LEADER + a` | 右 40% に Claude Code をトグル表示 |
| `LEADER + A` | 新規タブで Claude Code を開く |
| `LEADER + -` | ペインを縦分割 |
| `LEADER + \|` | ペインを横分割 |
| `LEADER + n/t/s/k` | ペイン移動（Tomisuke 配列） |
