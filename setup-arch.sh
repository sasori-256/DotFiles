#!/usr/bin/env bash
# Arch Linux に Nix（nixos.org 公式インストーラ・デーモン方式）を入れ、home-manager の初回 switch まで行う。
# 再実行しても安全（Nix が入っていればインストールは飛ばす）。
#
#   ./setup-arch.sh                  # homeConfigurations."$USER@$(uname -n)" を適用
#   ./setup-arch.sh <user>@<host>    # 適用する homeConfigurations を明示
#
# 前提: /nix が btrfs サブボリューム @nix としてマウント済み（手順は homelab の
# docs/runbook/arch-reinstall-runbook.md「8-2 先に /nix を専用サブボリュームにする」）。
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE="$DOTFILES/system"
ATTR="${1:-$USER@$(uname -n)}"
NIX_PROFILE=/nix/var/nix/profiles/default
NIX_CONF=/etc/nix/nix.conf
BLOCK_BEGIN="# >>> DotFiles setup-arch.sh >>>"
BLOCK_END="# <<< DotFiles setup-arch.sh <<<"

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
die() {
  printf '\033[1;31merror:\033[0m %s\n' "$*" >&2
  exit 1
}

[[ -f /etc/arch-release ]] || die "Arch Linux 専用"
[[ $EUID -ne 0 ]] || die "root ではなく一般ユーザーで実行する（必要な所だけ sudo を使う）"

step "/nix が @nix サブボリュームか確認"
# @ の中に /nix があると、snapper のスナップショットが膨らみ、@ を差し替えて巻き戻したときに
# /nix だけ過去に戻って @home 側の home-manager の世代と食い違う
nix_subvol="$(findmnt -n -o FSROOT /nix || true)"
[[ "$nix_subvol" == /@nix ]] ||
  die "/nix が @nix としてマウントされていない（今: '${nix_subvol:-マウントなし}'）。先にサブボリュームを作って fstab に足す"

pacman -Q nix &>/dev/null &&
  die "pacman 版の nix が入っている。公式インストーラと衝突するので先に sudo pacman -Rns nix する"

step "pacman: zsh / git / curl"
sudo pacman -S --needed zsh git curl

if [[ -x $NIX_PROFILE/bin/nix ]]; then
  step "Nix はインストール済み: $("$NIX_PROFILE/bin/nix" --version)"
else
  # pacman -Rns nix は sysusers.d で作られた nixbld グループ（GID 9xx）とユーザーを残す。
  # 公式インストーラは nixbld を GID 30000 で作ろうとし、既存の GID と違うと止まる
  getent group nixbld >/dev/null &&
    die "前の Nix の nixbld グループが残っている（$(getent group nixbld | cut -d: -f1,3)）。ユーザーとグループを消してから再実行する"
  step "Nix を公式インストーラで導入（デーモン方式）"
  curl --proto '=https' --tlsv1.2 -sSfL https://nixos.org/nix/install | sh -s -- --daemon
fi

step "$NIX_CONF に設定を書き込み"
# darwin/_common/system.nix の nix.settings と揃える。公式インストーラは flakes が既定で無効
sudo sed -i "/^${BLOCK_BEGIN}\$/,/^${BLOCK_END}\$/d" "$NIX_CONF"
sudo tee -a "$NIX_CONF" >/dev/null <<EOF
${BLOCK_BEGIN}
experimental-features = nix-command flakes
trusted-users = root ${USER}
extra-substituters = https://devenv.cachix.org
extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
${BLOCK_END}
EOF
sudo systemctl restart nix-daemon.service

# インストール直後のこのシェルにはまだ PATH が通っていない。
# home-manager の CLI は PATH 上の nix を呼ぶので、ここで読み込む
set +u
# shellcheck source=/dev/null
. "$NIX_PROFILE/etc/profile.d/nix-daemon.sh"
set -u

step "homeConfigurations.\"$ATTR\" の存在確認"
available="$(nix eval --raw "$FLAKE#homeConfigurations" \
  --apply 'a: builtins.concatStringsSep "\n" (builtins.attrNames a)')"
grep -Fxq "$ATTR" <<<"$available" ||
  die "\"$ATTR\" が flake にない。引数で指定するか system/flake.nix に追加する。定義済み: $(tr '\n' ' ' <<<"$available")"

step "home-manager switch"
# --inputs-from で flake.lock に固定された home-manager の CLI を使う
nix run --inputs-from "$FLAKE" home-manager -- switch --flake "$FLAKE#$ATTR" -b backup

# ログインシェルは pacman の zsh にする。Nix 側の zsh は /etc/shells に無く、
# Nix が壊れたときにログインできなくなるのも避けたい。.zshrc は home-manager 管理のものが使われる。
if [[ "$(getent passwd "$USER" | cut -d: -f7)" != /usr/bin/zsh ]]; then
  step "ログインシェルを /usr/bin/zsh に変更"
  sudo chsh -s /usr/bin/zsh "$USER"
fi

step "完了"
cat <<EOF
- 一度ログアウトして入り直す（PATH とログインシェルの反映）
- 以降の適用は: nh home switch
- switch で /run/opengl-driver の作成を促す警告が出ていたら、表示されたコマンドを実行する（targets.genericLinux.gpu）
- 1Password（SSH agent / コミット署名）は AUR の 1password を入れ、設定で SSH agent を有効化する
- Neovim の補完用モデル: ollama pull qwen2.5-coder:7b
EOF
