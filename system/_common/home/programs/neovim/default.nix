{ ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    imports = [
      ./options.nix
      ./keymaps.nix
      ./colorscheme.nix
      ./treesitter.nix
      ./lsp.nix
      ./completion.nix
      ./snacks.nix
      ./dashboard.nix
      ./ui.nix
      ./editor.nix
      ./lang
    ];
  };
}
