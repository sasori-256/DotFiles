{ pkgs, lib, username, ... }:

{
  imports = [
    ../../../_common/home/programs/neovim.nix
    ./packages.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/starship.nix
    ./programs/wezterm.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
  targets.darwin.linkApps.enable = true;
}
