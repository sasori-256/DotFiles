return {
  -- lsp icons like vscode
  {
    "onsails/lspkind.nvim",
    -- nvim-cmp.lua
    event = "InsertEnter",
  },
  -- mason.nvim and mason-lspconfig.nvim
  {
    "mason-org/mason.nvim",
    version = "*",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
      },
    },
    -- Removed config = true to let LazyVim handle it
  },
  -- mason-lspconfig configuration
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = {
        "jdtls",
      },
    },
    -- Removed config = true to let LazyVim handle it
  },
  -- lsp server configurations
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- pyright: Configure but we will handle its setup manually to silence it
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        -- ruff: Primary diagnostics
        ruff = {},
        -- jdtls: Java settings
        jdtls = {
          vmargs = {
            "-Dfile.encoding=UTF-8",
          },
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { enabled = true },
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                },
              },
            },
          },
        },
      },
      setup = {
        -- Take full control of pyright setup to ensure silence
        pyright = function(server, opts)
          -- Silence diagnostics
          opts.handlers = opts.handlers or {}
          opts.handlers["textDocument/publishDiagnostics"] = function() end

          -- Disable diagnostic capability
          if not opts.capabilities then
            opts.capabilities = vim.lsp.protocol.make_client_capabilities()
          end
          opts.capabilities.textDocument.publishDiagnostics = false

          -- Execute setup and return true to skip LazyVim's default setup
          require("lspconfig")[server].setup(opts)
          return true
        end,
      },
    },
  },
}
