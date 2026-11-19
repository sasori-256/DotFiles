{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [ "python" ];

    lsp.servers.ruff.enable = true;

    conform-nvim.settings.formatters_by_ft.python = [ "ruff_format" ];
    lint.lintersByFt.python = [ "ruff" ];
  };
}
