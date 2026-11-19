{ ... }:

{
  plugins = {
    treesitter.settings.ensure_installed = [
      "css"
      "html"
      "javascript"
      "json"
      "tsx"
      "typescript"
    ];

    lsp.servers = {
      ts_ls.enable = true;
      tailwindcss.enable = true;
      jsonls.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      javascript.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      typescript.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      javascriptreact.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      typescriptreact.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      css.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      json.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      jsonc.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
      html.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
    };

    lint.lintersByFt = {
      javascript = [
        "biome"
        "eslint"
      ];
      typescript = [
        "biome"
        "eslint"
      ];
      javascriptreact = [
        "biome"
        "eslint"
      ];
      typescriptreact = [
        "biome"
        "eslint"
      ];
      css = [ "biome" ];
      json = [ "biome" ];
      jsonc = [ "biome" ];
      html = [ "htmllint" ];
    };
  };
}
