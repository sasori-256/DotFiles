{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [ "yaml" ];

    lsp.servers.yamlls.enable = true;

    conform-nvim.settings.formatters_by_ft.yaml.__raw =
      ''{ "prettierd", "prettier", stop_after_first = true }'';
    lint.lintersByFt.yaml = [ "yamllint" ];
  };
}
