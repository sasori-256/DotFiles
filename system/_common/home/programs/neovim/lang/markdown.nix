{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [
      "markdown"
      "markdown_inline"
      "mdx"
    ];

    conform-nvim.settings.formatters_by_ft = {
      markdown = [
        "prettierd"
        "prettier"
      ];
      mdx = [
        "prettierd"
        "prettier"
      ];
    };

    lint.lintersByFt.markdown = [ "markdownlint" ];

    # Lint mdx through the eslint LSP (starts only with an eslint config, e.g. eslint-plugin-mdx)
    lsp.servers.eslint.filetypes = [ "mdx" ];

    render-markdown = {
      # "completion" is deprecated
      enable = true;
      settings = {
        latex.enabled = false;
      };
    };
  };

  extraConfigLua = ''
    vim.filetype.add({ extension = { mdx = "mdx" } })
    vim.treesitter.language.register("markdown", "mdx")
  '';
}
