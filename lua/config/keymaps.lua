-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymaps = vim.keymaps
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", "vb_d")

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

--New tab
keymap.set("n", "<s-t>e", ":tabledit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

--Split window
keymap.set("n", "<C-w><C-s>", ":split<Return>", opts)
keymap.set("n", "<C-w><C-v>", ":vsplit<Return>", opts)
--Move windows
keymap.set("n", "<C.w>n", "<C-w>h", opts)
keymap.set("n", "<C-w>t", "<C-w>j", opts)
keymap.set("n", "<C-w>s", "<C-w>k", opts)
keymap.set("n", "<C-w>k", "<C-w>l", opts)

--Resizo window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

--Diagnostic
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

--Set Tomisuke
keymap.set("n", "N", "Nzz", opts)
keymap.set("n", "K", "nzz", opts)
keymap.set("n", "n", "h", opts)
keymap.set("n", "t", "j", opts)
keymap.set("n", "s", "k", opts)
keymap.set("n", "k", "l", opts)
keyamp.set("i", "tt", "<Esc>", opts)
