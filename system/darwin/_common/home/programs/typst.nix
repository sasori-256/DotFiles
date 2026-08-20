{ config, ... }:

{
  # Typst は macOS では @local パッケージを ~/Library/Application Support/typst/packages/local
  # から探す（~/.local/share ではない）。mkOutOfStoreSymlink で DotFiles 内の実体に直接
  # symlink するので、テンプレートを編集すれば darwin-rebuild switch なしで即反映される。
  home.file."Library/Application Support/typst/packages/local/report-template/0.1.0".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/DotFiles/typst/report-template";
}
