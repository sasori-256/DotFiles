{ lib, ... }:

let
  biomeFts = [
    "javascript"
    "typescript"
    "javascriptreact"
    "typescriptreact"
    "css"
    "json"
    "jsonc"
  ];
  jsFts = [
    "javascript"
    "typescript"
    "javascriptreact"
    "typescriptreact"
  ];
in
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

    conform-nvim.settings.formatters_by_ft =
      lib.genAttrs biomeFts (_: [
        "biome"
        "prettierd"
        "prettier"
      ])
      // {
        html = [
          "prettierd"
          "prettier"
        ];
      };

    lint.lintersByFt =
      lib.genAttrs biomeFts (_: [ "biome" ])
      // lib.genAttrs jsFts (_: [
        "biome"
        "eslint"
      ])
      // {
        html = [ "htmllint" ];
      };
  };
}
