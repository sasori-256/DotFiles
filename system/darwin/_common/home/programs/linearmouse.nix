{ config, ... }:

{
  home.file.".config/linearmouse".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/DotFiles/linearmouse";
}
