{ ... }:

{
  imports = [
    ./packages.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/neovim
    ./programs/nh.nix
    ./programs/nix-update.nix
    ./programs/ollama.nix
    ./programs/skills.nix
    ./programs/ssh.nix
    ./programs/starship.nix
    ./programs/typst.nix
    ./programs/wezterm.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  programs.home-manager.enable = true;
}
