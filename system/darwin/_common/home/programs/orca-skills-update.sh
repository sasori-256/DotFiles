#!/usr/bin/env bash
# orca.nix の rev / hash を stablyai/orca の最新 main に更新する。
#
# orca.nix の skills = { ... } に並んでいる skill 名をそのまま読み、
# rev と各 hash を引き直して書き戻す。skill を増やすときは orca.nix に
#     <name> = "";
# の行を足してからこれを走らせればよい（hash は埋めなくてよい）。
#
# 更新後は `nh darwin switch .` で反映する。
set -euo pipefail

nix_file="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/orca.nix"
repo="stablyai/orca"

names=$(sed -n '/^  skills = {/,/^  };/p' "$nix_file" |
  sed -nE 's/^    ([A-Za-z0-9_-]+) = .*/\1/p')
[[ -n $names ]] || {
  echo "orca.nix から skill 名を読めなかった" >&2
  exit 1
}

old_rev=$(sed -nE 's/^  rev = "([0-9a-f]{40})";/\1/p' "$nix_file")
new_rev=$(curl -fsSL "https://api.github.com/repos/$repo/commits/main" | jq -r .sha)
[[ $new_rev =~ ^[0-9a-f]{40}$ ]] || {
  echo "main の rev を取得できなかった" >&2
  exit 1
}

if [[ $old_rev == "$new_rev" ]]; then
  echo "rev は最新 ($new_rev)"
else
  echo "rev: ${old_rev:0:12} -> ${new_rev:0:12}"
fi

block=""
changed=0
while read -r name; do
  old_hash=$(sed -nE "s/^    $name = \"(.*)\";/\1/p" "$nix_file")
  url="https://raw.githubusercontent.com/$repo/$new_rev/skills/$name/SKILL.md"
  new_hash=$(nix store prefetch-file --json "$url" | jq -r .hash)
  if [[ $old_hash == "$new_hash" ]]; then
    printf '  %-18s 変更なし\n' "$name"
  else
    printf '  %-18s 更新あり\n' "$name"
    changed=1
  fi
  block+="    $name = \"$new_hash\";"$'\n'
done <<<"$names"

REV="$new_rev" BLOCK="$block" perl -0777 -i -pe '
  s/^  rev = "[0-9a-f]{40}";$/  rev = "$ENV{REV}";/m;
  s/^(  skills = \{\n).*?^(  \};)$/$1$ENV{BLOCK}$2/ms;
' "$nix_file"

command -v nixfmt >/dev/null && nixfmt "$nix_file"

if ((changed)); then
  echo "stub が変わった。nh darwin switch . で反映する。"
else
  echo "stub の内容は同じ。"
fi
