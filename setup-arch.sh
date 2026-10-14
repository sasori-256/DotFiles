#!/usr/bin/env bash
# Arch Linux に Nix (pacman 版) を入れ、home-manager の初回 switch まで行う。再実行しても安全。
#
#   ./setup-arch.sh                  # homeConfigurations."$USER@$(uname -n)" を適用
#   ./setup-arch.sh <user>@<host>    # 適用する homeConfigurations を明示
#
# pacman -S は -y を付けないので、DB が古くて 404 になる場合は先に sudo pacman -Syu しておく。
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE="$DOTFILES/system"
ATTR="${1:-$USER@$(uname -n)}"
NIX_CONF=/etc/nix/nix.conf
BLOCK_BEGIN="# >>> DotFiles setup-arch.sh >>>"
BLOCK_END="# <<< DotFiles setup-arch.sh <<<"

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
die() {
  printf '\033[1;31merror:\033[0m %s\n' "$*" >&2
  exit 1
}

# nix-daemon のソケットは nix-users グループ限定。usermod 直後のこのシェルにはまだ
# グループが反映されていないので、再ログインせずに済むよう sg 経由で叩く。
run_nix() {
  if getent group nix-users >/dev/null && ! id -nG | grep -qw nix-users; then
    sg nix-users -c "$(printf '%q ' "$@")"
  else
    "$@"
  fi
}

[[ -f /etc/arch-release ]] || die "Arch Linux 専用"
[[ $EUID -ne 0 ]] || die "root ではなく一般ユーザーで実行する（必要な所だけ sudo を使う）"

step "pacman: nix / zsh / git"
sudo pacman -S --needed nix zsh git

step "$NIX_CONF に設定を書き込み"
# darwin/_common/system.nix の nix.settings と揃える
sudo sed -i "/^${BLOCK_BEGIN}\$/,/^${BLOCK_END}\$/d" "$NIX_CONF"
sudo tee -a "$NIX_CONF" >/dev/null <<EOF
${BLOCK_BEGIN}
experimental-features = nix-command flakes
trusted-users = root ${USER}
extra-substituters = https://devenv.cachix.org
extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
${BLOCK_END}
EOF

step "nix-daemon を有効化"
sudo systemctl enable --now nix-daemon.socket
# 稼働中のデーモンは nix.conf を読み直さないので再起動する（未起動なら何もしない）
sudo systemctl try-restart nix-daemon.service

if getent group nix-users >/dev/null && ! id -nG "$USER" | grep -qw nix-users; then
  step "$USER を nix-users に追加"
  sudo usermod -aG nix-users "$USER"
fi

step "homeConfigurations.\"$ATTR\" の存在確認"
available="$(run_nix nix eval --raw "$FLAKE#homeConfigurations" \
  --apply 'a: builtins.concatStringsSep "\n" (builtins.attrNames a)')"
grep -Fxq "$ATTR" <<<"$available" ||
  die "\"$ATTR\" が flake にない。引数で指定するか system/flake.nix に追加する。定義済み: $(tr '\n' ' ' <<<"$available")"

step "home-manager switch"
# --inputs-from で flake.lock に固定された home-manager の CLI を使う
run_nix nix run --inputs-from "$FLAKE" home-manager -- \
  switch --flake "$FLAKE#$ATTR" -b backup

# ログインシェルは pacman の zsh にする。Nix 側の zsh は /etc/shells に無く、
# Nix が壊れたときにログインできなくなるのも避けたい。.zshrc は home-manager 管理のものが使われる。
if [[ "$(getent passwd "$USER" | cut -d: -f7)" != /usr/bin/zsh ]]; then
  step "ログインシェルを /usr/bin/zsh に変更"
  sudo chsh -s /usr/bin/zsh "$USER"
fi

step "完了"
cat <<EOF
- 一度ログアウトして入り直す（nix-users グループとログインシェルの反映）
- 以降の適用は: nh home switch
- 1Password（SSH agent / コミット署名）は AUR の 1password を入れ、設定で SSH agent を有効化する
- Neovim の補完用モデル: ollama pull qwen2.5-coder:7b
EOF
