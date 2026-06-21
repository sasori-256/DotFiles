{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- CLI tools ---
    _1password-cli
    git
    gh
    lazygit
    fd
    fzf
    ripgrep
    bat
    eza
    zoxide
    starship
    fastfetch
    claude-code
    tree-sitter
    chafa # Create ASCII/Unicode art from images in the terminal

    # --- Fonts ---
    moralerspace

    # --- Dev tools ---
    # python
    uv

    # node
    biome
    prettierd
    eslint
    markdownlint-cli2

    # python
    ruff

    # lua
    stylua
    selene

    # nix
    nixfmt
    statix

    # yaml / html
    yamllint
  ];
}
