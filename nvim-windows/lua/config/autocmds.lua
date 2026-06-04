-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Re-apply transparent background after colorscheme changes
-- Required in Neovim 0.12: NormalFloat and related groups need explicit clearing
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local groups = { "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle", "SignColumn" }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
  end,
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel for json files-
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})
