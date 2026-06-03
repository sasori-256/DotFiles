{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    nix-output-monitor
    _1password-cli
    git
    gh
    lazygit
    neovim
    fd
    fzf
    ripgrep
    bat
    eza
    zoxide
    starship
    fastfetch
    claude-code

    # Fonts
    moralerspace

    # Dev tools
    uv
  ];
}
