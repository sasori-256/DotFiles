{ ... }:

{
  imports = [
    ./packages.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/nh.nix
    ./programs/ollama.nix
    ./programs/ssh.nix
    ./programs/starship.nix
    ./programs/typst.nix
    ./programs/wezterm.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  programs.home-manager.enable = true;
}
