{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [
      "markdown"
      "markdown_inline"
      "mdx"
    ];

    conform-nvim.settings.formatters_by_ft = {
      markdown.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
      mdx.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
    };

    lint.lintersByFt = {
      markdown = [ "markdownlint" ];
      mdx = [
        "eslint"
      ];
    };

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
