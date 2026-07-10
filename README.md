# DotFiles

Neovim, WezTerm, Starship などの設定を管理するリポジトリ。
全ツールで **Catppuccin Frappe** テーマに統一。

## 対応環境

| 環境 | 管理方法 |
|---|---|
| macOS | nix-darwin + home-manager |
| Linux (予定) | NixOS / home-manager |
| Windows | `setup-windows.ps1` + シンボリックリンク |

---

## 構成

```
DotFiles/
├── nvim-windows/        # Windows 専用 Neovim 設定 (LazyVim ベース)
├── wezterm/             # WezTerm 設定 (Windows / macOS 共用)
├── starship.toml        # Starship 設定 (Windows / macOS 共用)
├── powershell/          # PowerShell 設定
├── fonts/moralerspace/  # カスタムフォントの Nix derivation
├── setup-windows.ps1    # Windows: Scoop/Winget + シンボリックリンク
└── system/              # Nix 設定 (macOS、将来 Linux も)
    ├── flake.nix
    ├── flake.lock
    ├── _common/
    │   └── home/programs/
    │       └── neovim.nix   # NixVim 設定 (macOS / Linux 共用)
    └── darwin/
        ├── _common/
        │   ├── system.nix   # Homebrew casks、macOS defaults
        │   └── home/
        │       ├── default.nix
        │       ├── packages.nix
        │       └── programs/ # fzf, git, direnv, starship, wezterm, zsh ...
        └── <hostname>/
            ├── system.nix
            └── home.nix
```

---

## セットアップ

### macOS

```bash
git clone https://github.com/sasori-256/DotFiles.git ~/DotFiles
cd ~/DotFiles/system
darwin-rebuild switch --flake . |& nom
```

初回は [nix-darwin](https://github.com/LnL7/nix-darwin) と [home-manager](https://github.com/nix-community/home-manager) のインストールが別途必要。

### Windows

PowerShell を管理者権限で開く:

```powershell
cd ~\DotFiles
.\setup-windows.ps1
```

---

## Neovim

### macOS — NixVim

Nix で完全宣言的に管理。プラグインのインストールは不要、リビルドで即反映。

- **補完**: blink.cmp
- **LSP**: nvim-lspconfig (Nix がバイナリ管理、mason 不要)
- **ファイラー**: mini.files
- **ピッカー**: snacks.nvim
- **AI 補完**: copilot.lua (ghost text)
- **フォーマット**: conform.nvim
- **リント**: nvim-lint

### Windows — LazyVim

`nvim-windows/` ディレクトリを `%LOCALAPPDATA%\nvim` にシンボリックリンク。

---

## WezTerm

- **フォント**: Moralerspace Neon (Nerd Font)
- **カラースキーム**: Catppuccin Frappe
- **背景透過**: 0.85
- **リーダーキー**: `Ctrl+,`

### 主なキーバインド

| キー | 動作 |
|---|---|
| `LEADER + a` | 右 40% に Claude Code を開く (トグル) |
| `LEADER + A` | 新規タブで Claude Code を開く |
| `LEADER + -` | ペインを縦分割 |
| `LEADER + \|` | ペインを横分割 |
| `LEADER + z` | ペインをズーム |
| `LEADER + n/t/s/k` | ペイン移動 (Tomisuke 配列) |

---

## 開発環境管理 (direnv + nix-direnv)

言語ランタイムはプロジェクト単位で管理。`cd` するだけで自動切替。

### プロジェクトの初期化

```bash
cd ~/your-project
cat > flake.nix << 'EOF'
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { nixpkgs, ... }:
    let pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    in {
      devShells.aarch64-darwin.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs_22
          # python312
          # cargo
        ];
      };
    };
}
EOF

echo "use flake" > .envrc
direnv allow
```

### グローバルに入れているツール

| ツール | 用途 |
|---|---|
| `uv` | Python 環境管理 |
| `biome` | JS/TS フォーマット・リント (フォールバック) |
| `prettierd` | 汎用フォーマット (フォールバック) |
| `stylua` | Lua フォーマット |
| `nixfmt` | Nix フォーマット |

プロジェクト内に `node_modules/.bin/biome` があれば、conform.nvim はそちらを優先して使う。

---

## テーマ

全ツールで **Catppuccin Frappe** に統一。新しいツールを追加する際もこのテーマに合わせる。
