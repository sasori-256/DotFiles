# My Dotfiles

このリポジトリは、私の個人的な設定ファイル（Dotfiles）を管理するものです。
Neovim, WezTerm, Starshipなどの設定が含まれており、Catppuccin Frappeテーマを基調とした統一感のある開発環境を目指しています。

## 概要

- **Neovim**: [LazyVim](https://github.com/LazyVim/LazyVim)をベースにした設定
- **WezTerm**: GPUアクセラレーション対応のターミナルエミュレータ
- **Starship**: 高速でカスタマイズ性の高いプロンプト

## 特徴

### Neovim

- **ベース**: [LazyVim](https://github.com/LazyVim/LazyVim)
- **カラースキーム**: [Catppuccin for Nvim](https://github.com/catppuccin/nvim) (Frappe)
- **LSP & Formatter**: `mason.nvim` を通じて、以下のツールを導入しています。
  - `stylua`, `selene`, `luacheck` (Lua)
  - `shellcheck`, `shfmt` (Shell)
  - `tailwindcss-language-server`, `css-lsp` (Web)
  - `dart-debug-adapter` (Dart)
  - `tinymist` (Typst)
- **キーマップ**:
  - Tomisuke配列ライクな移動キー (`<A-n>`, `<A-t>`, `<A-s>`, `<A-k>`)
  - ウィンドウ分割・移動のショートカット
  - Gemini (AI) との連携機能 (`<leader>ga`, `<leader>gc`など)

### WezTerm

- **フォント**: [Moralerspace Neon](https://github.com/yuru7/moralerspace) (Nerd Font)
- **カラースキーム**: Catppuccin Frappe
- **外観**:
  - 背景透過 (Opacity: 0.85)
  - タブバーを画面下部に表示
- **キーバインド**: `CTRL+,` をリーダーキーとしたカスタムキーバインドを設定

### Starship

- **テーマ**: Catppuccin Frappeのカラーをベースにしたカスタムテーマ
- **表示項目**:
  - OS, ディレクトリ, Gitブランチ/ステータス
  - コマンド実行時間
  - 各種プログラミング言語のバージョン
  - 現在時刻

## セットアップ

1.  このリポジトリをクローンします。
    ```bash
    git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
    ```

2.  各設定ファイルのシンボリックリンクをホームディレクトリ以下の適切な場所に作成します。

    ```bash
    # Neovim
    ln -s ~/.dotfiles/nvim ~/.config/nvim

    # WezTerm
    ln -s ~/.dotfiles/wezterm ~/.config/wezterm

    # Starship
    ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml
    ```

**Note:** `setup-nvim.ps1`は、Windows環境向けのNeovimセットアップ用PowerShellスクリプトです。
