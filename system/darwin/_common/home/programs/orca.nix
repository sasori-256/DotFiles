{ lib, pkgs, ... }:

let
  # Orca ADE の設定画面は skill の導入に
  #   npx skills add https://github.com/stablyai/orca --skill <name> --global
  # を案内してくるが、これがやっているのは skills/<name>/SKILL.md を
  # ~/.claude/skills/<name>/ にコピーするだけ。しかもその SKILL.md は
  # 「orca skills get <name> で本体のガイドを取ってこい」と書いてある
  # discovery stub で、手順の実体は Orca.app 側にバンドルされている
  # （`orca skills list` / `orca skills get <name>` で確認できる）。
  #
  # よって node / npm はインストール時にしか要らず、ランタイム依存でもない。
  # グローバルに node を生やす代わりにここで stub を直接取得して配置する。
  #
  # なお skills CLI を通さないので ~/.agents/.skill-lock.json が作られず、
  # Orca は「自動更新できない」と警告する。stub が指す本体ガイドは cask 更新で
  # 勝手に新しくなるので実害は小さいが、frontmatter の description だけは
  # ここを更新しないと古いままになる（description は Claude Code が skill を
  # 読み込むか判断する材料なので、放置すると発火精度が落ちる）。
  # rev と hash の更新は ./orca-skills-update.sh で行う。
  rev = "893152fa0c243eb636ff731469116aa072538c6d";

  # 追加できる skill 名は `orca skills list` で一覧できる。
  # ここに名前を足して ./orca-skills-update.sh を走らせれば hash が埋まる。
  skills = {
    computer-use = "sha256-KDmTP9NSFoRUYUZkA+YGFIgAX231cSbQzQ92nqRXU/M=";
    orca-cli = "sha256-6XWa6mZPVFYZRu60CmMoAxMwhgzaCBfywqos9SnVwbM=";
    orca-emulator = "sha256-PacZEXnkbLDhpqk28etUJU9umOw4hJ4clfDhEHMHa0g=";
    orca-emulator-android = "sha256-Ot5Ob48nF8qJn9hB5h8RaWOkBulScBW4A4VMFtAS4ng=";
    orchestration = "sha256-ZtTGCj6tVOsGOlc0EnjMyvKOAWwoR6bxgIoNTS0WNgY=";
  };
in
{
  home.file = lib.mapAttrs' (
    name: hash:
    lib.nameValuePair ".claude/skills/${name}/SKILL.md" {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/stablyai/orca/${rev}/skills/${name}/SKILL.md";
        inherit hash;
      };
    }
  ) skills;
}
