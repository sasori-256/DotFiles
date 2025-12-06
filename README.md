# My Dotfiles

このリポジトリは、私の個人用設定ファイル（Dotfiles）を管理するものです。
Neovim, WezTerm, Starshipなどの設定が含まれており、Catppuccin Frappeテーマを基調とした統一感のある開発環境を目指しています。

## 概要

- **nvim**: [LazyVim](https://github.com/LazyVim/LazyVim)をベースにした設定ファイル群
- **powershell**: Windows環境用のPowershellの設定ファイル群
- **wezterm**: GPUアクセラレーション対応のターミナルエミュレータ用の設定ファイル群
- **fish**: Fishシェル用の設定ファイル群(追加予定)
- **hyprland**: Hyprlandウィンドウマネージャ用の設定ファイル群(追加予定)
- **setup-nvim.ps1**: Windows環境向けのNeovimセットアップ用PowerShellスクリプト(deprecated)
- **setup-windows.ps1**: Windows環境向けの全体セットアップ用PowerShellスクリプト
- **starship.toml**: 高速でカスタマイズ性の高いプロンプト用の設定ファイル

## 特徴

### Neovim

- **ベース**: [LazyVim](https://github.com/LazyVim/LazyVim)
- **カラースキーム**: [Catppuccin for Nvim](https://github.com/catppuccin/nvim) (Frappe)
- **LSP & Formatter**: `mason.nvim` を通じて各種言語サーバーとフォーマッターをインストール・管理
- **キーマップ**:
  - Tomisuke配列ライクな移動キー (`<A-n>`, `<A-t>`, `<A-s>`, `<A-k>`)
  - ウィンドウ分割(`<leader>-`, `<leader>|`)・移動のショートカット
  - Gemini (AI) との連携機能 (`<leader>ga`, `<leader>gc`など)

### WezTerm

- **フォント**: [Moralerspace Neon](https://github.com/yuru7/moralerspace) (Nerd Font)
- **カラースキーム**: Catppuccin Frappe
- **外観**:
  - 背景透過 (Opacity: 0.85)
  - タブバーを画面下部に表示
- **キーバインド**: `CTRL+,` をリーダーキーとしたカスタムキーバインドを設定
  - 新しいタブの作成 (`CTRL+SHIFT+t`)
  - タブ間の移動 (`CTRL+TAB`, `CTRL+SHIFT+TAB`)
  - ペインの分割 (`LEADER+CTRL+-`, `LEADER+CTRL+|`)

### Starship

- **テーマ**: Catppuccin Frappeのカラーをベースにしたカスタムテーマ
- **表示項目**:
  - OS, ディレクトリ, Gitブランチ/ステータス
  - コマンド実行時間
  - 各種プログラミング言語のバージョン
  - 現在時刻

## セットアップ

1. このリポジトリをクローンします。

   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
   ```

2. Windows環境の場合、PowerShellを管理者権限で開き、セットアップスクリプトを実行します。

   ```powershell
   cd ~/.dotfiles
   .\setup-windows.ps1
   ```

3. NeovimやWezTermの設定が正しく反映されていることを確認します。

4. 必要に応じて、各アプリケーションの設定をカスタマイズしてください。

- setup-windows.ps1のapps配列に必要なアプリケーションを追加することで、自動インストールが可能です。
