{
  config,
  lib,
  df-root,
  context7,
  ponytail,
  yomiyasu,
  ...
}:

let
  # Claude Code は ~/.claude/skills、Orca や Codex などは ~/.agents/skills を読む。
  # 同じ skill を両方に置く。
  targets = [
    ".claude/skills"
    ".agents/skills"
  ];

  # 自作 skill: リポジトリ直下の skills/<name>/ を丸ごとリンクする。
  # mkOutOfStoreSymlink なので switch せずに編集が反映される。
  # skills/ にディレクトリを足すだけで拾う（flake は git 管理外のファイルを
  # 見ないので、足したら `git add` すること）。
  own = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir (df-root "skills")));

  # 上流 skill: flake input で rev を固定している。
  # 更新は `nix flake update <input名>`（context7 / ponytail / yomiyasu）。
  upstream = {
    find-docs = "${context7}/skills/find-docs";
    ponytail = "${ponytail}/skills/ponytail";
    yomiyasu = "${yomiyasu}/skills/yomiyasu";
  };

  entries =
    (map (name: {
      inherit name;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/DotFiles/skills/${name}";
    }) own)
    ++ lib.mapAttrsToList (name: source: { inherit name source; }) upstream;
in
{
  home.file = lib.listToAttrs (
    lib.concatMap (
      target:
      map (e: lib.nameValuePair "${target}/${e.name}" { source = e.source; }) entries
    ) targets
  );
}
