{ config, ... }:

{
  home.file.".config/herdr/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/DotFiles/herdr/config.toml";
}
