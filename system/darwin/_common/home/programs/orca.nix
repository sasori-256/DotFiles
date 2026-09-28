{ lib, pkgs, ... }:

let
  # Orca ADE の設定画面は skill の導入に
  #   npx skills add https://github.com/stablyai/orca --skill <name> --global
  # を案内してくるが、これがやっているのは skills/<name>/SKILL.md を
  # ~/.claude/skills/<name>/ にコピーするだけ。しかもその SKILL.md は
  # 「orca skills get <name> で本体のガイドを取ってこい」と書いてある
  # discovery stub で、実体は Orca.app 側にバンドルされている
  # （`orca skills list` / `orca skills get <name>` で確認できる）。
  #
  # よって node / npm はインストール時にしか要らず、ランタイム依存でもない。
  # グローバルに node を生やす代わりにここで stub を直接取得して配置する。
  # stub は Orca のバージョンに追従しない作りなので rev 固定で問題ない。
  rev = "bf9194126e5e4fd722aedf268f4bf67bf5cd232f";

  # 追加したい skill は `orca skills list` で一覧できる。
  # hash は下記で取得:
  #   nix store prefetch-file https://raw.githubusercontent.com/stablyai/orca/<rev>/skills/<name>/SKILL.md
  skills = {
    computer-use = "sha256-KDmTP9NSFoRUYUZkA+YGFIgAX231cSbQzQ92nqRXU/M=";
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
