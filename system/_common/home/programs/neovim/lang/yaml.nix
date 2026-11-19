{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [ "yaml" ];

    lsp.servers.yamlls.enable = true;

    conform-nvim.settings.formatters_by_ft.yaml = [
      "prettierd"
      "prettier"
    ];
    lint.lintersByFt.yaml = [ "yamllint" ];
  };
}
