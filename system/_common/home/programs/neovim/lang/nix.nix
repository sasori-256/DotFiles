{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [ "nix" ];

    conform-nvim.settings.formatters_by_ft.nix = [ "nixfmt" ];
    lint.lintersByFt.nix = [ "statix" ];
  };
}
