-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
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
keymap.set("n", "<s-t>e", ":tabedit<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

--Split window
keymap.set("n", "w<C-s>", ":split<Return>", opts)
keymap.set("n", "w<C-v>", ":vsplit<Return>", opts)
--Move windows
keymap.set("n", "wn", "<C-w>h", opts)
keymap.set("n", "wt", "<C-w>j", opts)
keymap.set("n", "ws", "<C-w>k", opts)
keymap.set("n", "wk", "<C-w>l", opts)

--Resizo window
keymap.set("n", "w<Left>", "<C-w>>")
keymap.set("n", "w<Right>", "<C-w><")
keymap.set("n", "w<Up>", "<C-w>+")
keymap.set("n", "w<Down>", "<C-w>-")

--Diagnostic
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

--Set Tomisuke
keymap.set("n", "H", "Nzz", opts)
keymap.set("n", "h", "nzz", opts)
keymap.set({ "n", "v" }, "n", "h", opts)
keymap.set({ "n", "v" }, "t", "j", opts)
keymap.set({ "n", "v" }, "s", "k", opts)
keymap.set({ "n", "v" }, "k", "l", opts)
keymap.set("n", "j", "s", opts)

keymap.set("i", "tt", "<Esc>", opts)
keymap.set("i", "<C-n>", "<Left>", opts)
keymap.set("i", "<C-t>", "<Down>", opts)
keymap.set("i", "<C-s>", "<Up>", opts)
keymap.set("i", "<C-k>", "<Right>", opts)
