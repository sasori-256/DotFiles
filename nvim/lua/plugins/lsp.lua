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
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    dependencies = {
      { "mason-org/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
  },
}
