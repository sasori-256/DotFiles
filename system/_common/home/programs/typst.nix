{ config, pkgs, ... }:

let
  # Typst は @local パッケージを macOS では ~/Library/Application Support/typst/packages/local、
  # Linux では $XDG_DATA_HOME/typst/packages/local から探す。mkOutOfStoreSymlink で DotFiles 内の
  # 実体に直接 symlink するので、テンプレートを編集すれば switch なしで即反映される。
  dataDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "${config.home.homeDirectory}/Library/Application Support"
    else
      config.xdg.dataHome;
in
{
  home.file."${dataDir}/typst/packages/local/report-template/0.1.0".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/DotFiles/typst/report-template";
}
