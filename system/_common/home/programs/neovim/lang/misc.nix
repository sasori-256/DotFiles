{ ... }:

# Languages with only a parser or an LSP server
{
  plugins = {
    treesitter.settings.ensure_installed = [
      "rust"
      "toml"
    ];

    lsp.servers = {
      dockerls.enable = true;
      sqls.enable = true;
    };
  };
}
