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

## Homebrew の運用

**cask の更新は `nh darwin switch` から切り離してある**（`onActivation.upgrade = false`）。

`upgrade = true` だと nix-darwin が `brew bundle` に `--no-upgrade` を付けなくなり、switch のたびに古い cask を全部ダウンロードし直す。cask が 20 個を超えると「毎回どれかが古い」状態になり、activation が数百 MB のダウンロード待ちで数分固まる。しかも `nh` は activation の stderr をバッファして失敗時にしか出さないため、画面は `Activating configuration` のまま無反応に見える。

| やりたいこと | 方法 |
|---|---|
| cask を新規インストール | `system.nix` の `homebrew.casks` に足して `nh darwin switch .`（`--no-upgrade` が抑えるのは既存の更新だけ） |
| cask をまとめて更新 | `brew upgrade --cask` を手で叩く |
| 個別の cask を更新 | 各アプリの自前の更新機構に任せる（Discord / VS Code / Firefox / Obsidian / 1Password / Raycast はすべて持っている） |
| ダウンロードキャッシュの掃除 | `brew cleanup --prune=all`（`cleanup = "none"` なので自動では減らない。放置すると 10 GB 超になる） |

**formula は入れない。** `/opt/homebrew/bin` は `home.sessionPath` で PATH に通してあるが、これは `brew` 自体をデバッグ用に叩くため。`home.sessionPath` は PATH の**先頭**に足すので、`brew install <formula>` すると Nix 側の CLI ツールを黙って上書きする。CLI ツールは `home/packages.nix` に足すこと。

### `brew bundle` の fetch 失敗

```
`brew bundle` failed! Failed to fetch discord, notion, obsidian, ...
```

これは「全部失敗した」という意味では**ない**。`brew bundle` は更新対象をまとめて 1 回の `brew fetch` 子プロセスに渡すので、1 個でも失敗するとメッセージには渡した名前が全部並ぶ（`Library/Homebrew/bundle/installer.rb`）。だいたいはベンダー CDN 側の一時的な失敗なので、まず再実行する。どの cask が原因か知りたいときは手で叩く:

```bash
brew bundle --file="$(grep -o "/nix/store/[^']*-Brewfile" /run/current-system/activate)" --verbose
```

## activation が遅いときの調べ方

`nh` は activation の出力を隠すので、切り分けには activation スクリプトを直接叩いて各行にタイムスタンプを付ける（現在の世代の再適用なので冪等）:

```bash
sudo /run/current-system/activate 2>&1 | perl -MTime::HiRes=time -ne 'BEGIN{$|=1;$s=time} printf "%6.2fs  %s", time-$s, $_'
```

更新が何もない状態でのベースライン（2026-08 実測、hirasaka46）:

| フェーズ | 実測 |
|---|---|
| eval + build (`nix build .#darwinConfigurations.<host>.system`) | 約 10s |
| activation スクリプト全体 | 約 6.5s |
| └ Homebrew | 1.5s |
| └ home-manager | 1.2s |
| └ nix-daemon 再起動 | 0.13s |

これより大幅に遅ければ Homebrew の cask 更新を疑う。なお `reloading nix-daemon... / waiting for nix-daemon` は毎回必ず出る。`nix.buildMachines` 未設定だと `/etc/nix/machines` が両側とも存在せず `diff` が終了コード 2 を返すため、nix-darwin 側の条件式が常に成立するせい。実測 0.13s なので無視してよい。

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
