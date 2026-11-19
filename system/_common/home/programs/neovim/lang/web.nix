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

  # Formatters that run only when the project has their config file,
  # in priority order (biome -> oxfmt -> prettier)
  projectFormatters = {
    biome_project = "biome";
    prettierd_project = "prettierd";
    prettier_project = "prettier";
  };
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

      # Linters run as LSP servers, which start only when the project has their config file
      biome.enable = true;
      oxlint = {
        enable = true;
        # lspconfig's root_dir calls on_dir(nil) when no config is found, which
        # starts oxlint in single-file mode. Start it only when a root is found.
        extraOptions.root_dir.__raw = ''
          function(bufnr, on_dir)
            local default = dofile(vim.api.nvim_get_runtime_file("lsp/oxlint.lua", false)[1])
            default.root_dir(bufnr, function(dir)
              if dir then on_dir(dir) end
            end)
          end
        '';
      };
      eslint = {
        enable = true;
        # lspconfig's defaults; other modules may append to this list
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
          "vue"
          "svelte"
          "astro"
          "htmlangular"
        ];
      };
    };

    conform-nvim.settings = {
      formatters_by_ft =
        lib.genAttrs biomeFts (_: [
          "biome_project"
          "oxfmt"
          "prettierd_project"
          "prettier_project"
          # Without any config file, format with biome's defaults
          "biome"
        ])
        // {
          html = [
            "prettierd"
            "prettier"
          ];
        };

      formatters =
        lib.mapAttrs (_: parent: {
          "inherit" = parent;
          require_cwd = true;
        }) projectFormatters
        // {
          oxfmt.require_cwd = true;
        };
    };

    lint.lintersByFt.html = [ "htmllint" ];
  };
}
