{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [ "scheme" ];

    lsp.servers.guile_ls = {
      enable = true;
      package = null;
    };

    conform-nvim.settings = {
      formatters_by_ft.scheme = [ "schemat" ];
      formatters.schemat = {
        command = "schemat";
        stdin = true;
      };
    };
  };
}
