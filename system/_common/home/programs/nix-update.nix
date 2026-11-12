{ config, pkgs, ... }:

let
  flakeDir = "${config.home.homeDirectory}/DotFiles/system";
  switchCmd = if pkgs.stdenv.hostPlatform.isDarwin then "nh darwin switch" else "nh home switch";

  # flake.lock を更新して switch する。失敗したら更新前の flake.lock に戻す。
  # (git checkout だと未コミットの変更ごと巻き戻るので、ファイルのコピーで退避する)
  nix-update = pkgs.writeShellApplication {
    name = "nix-update";
    text = ''
      lock="${flakeDir}/flake.lock"
      backup="$(mktemp)"
      cp "$lock" "$backup"

      restore() {
        cp "$backup" "$lock"
        echo "nix-update: switch に失敗 flake.lock を復元" >&2
      }

      nix flake update --flake "${flakeDir}"

      if ${switchCmd} "${flakeDir}"; then
        rm -f "$backup"
      else
        status=$?
        restore
        rm -f "$backup"
        exit "$status"
      fi
    '';
  };
in
{
  home.packages = [ nix-update ];
}
