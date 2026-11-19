{ ... }:

{
  plugins = {
    # --- LSP ---
    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        lspBuf = {
          "<leader>ld" = {
            action = "definition";
            desc = "Go to definition";
          };
          "<leader>lr" = {
            action = "references";
            desc = "Show references";
          };
          "<leader>li" = {
            action = "implementation";
            desc = "Go to implementation";
          };
          "<leader>ls" = {
            action = "signature_help";
            desc = "Signature help";
          };
        };
      };
      servers = {
        ruff.enable = true;
        ts_ls.enable = true;
        clangd = {
          enable = true;
          cmd = [
            "clangd"
            "--background-index"
            "--clang-tidy"
            "--completion-style=detailed"
            "--header-insertion=iwyu"
            "--pch-storage=memory"
          ];
        };
        tailwindcss.enable = true;
        dockerls.enable = true;
        cmake.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        sqls.enable = true;
        guile_ls = {
          enable = true;
          package = null;
        };
        jdtls = {
          enable = true;
          extraOptions = {
            # Per-project workspace: cache/jdtls/<project-name>
            cmd.__raw = ''
              {
                "jdtls",
                "--data=" .. vim.fn.stdpath("cache") .. "/jdtls/" ..
                  vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
              }
            '';
            # Register $JAVA_HOME (set per project by devenv) under the name
            # matching its actual version; a mismatched name is ignored by jdtls.
            settings.java.configuration.runtimes.__raw = ''
              (function()
                local h = vim.env.JAVA_HOME
                if not h or h == "" then return {} end
                local f = io.open(h .. "/release")
                if not f then return {} end
                local v = f:read("*a"):match('JAVA_VERSION="([^"]+)"')
                f:close()
                if not v then return {} end
                local major = v:match("^1%.(%d+)") or v:match("^(%d+)")
                local name = major == "8" and "JavaSE-1.8" or ("JavaSE-" .. major)
                return {{ name = name, path = h, default = true }}
              end)()
            '';
          };
        };
      };
    };

    lazydev.enable = true;
    fidget.enable = true;

    # --- Formatter ---
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          javascript.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          typescript.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          javascriptreact.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          typescriptreact.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          css.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          json.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          jsonc.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
          html.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
          yaml.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
          markdown.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
          mdx.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
          python = [ "ruff_format" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          scheme = [ "schemat" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
        formatters = {
          schemat = {
            command = "schemat";
            stdin = true;
          };
        };
      };
    };

    # --- Linter ---
    lint = {
      enable = true;
      lintersByFt = {
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
        yaml = [ "yamllint" ];
        markdown = [ "markdownlint" ];
        mdx = [
          "eslint"
        ];
        python = [ "ruff" ];
        lua = [ "selene" ];
        nix = [ "statix" ];
      };
    };

    # --- Languages ---
    clangd-extensions = {
      enable = true;
      enableOffsetEncodingWorkaround = true;
    };

    cmake-tools = {
      enable = true;
      settings = {
        cmake_build_directory = "build";
        cmake_soft_link_compile_commands = true;
        cmake_generate_options.__raw = ''{ "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }'';
      };
    };
  };

  extraConfigLua = ''
    -- LSP inlay hints
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true)
    end
  '';
}
