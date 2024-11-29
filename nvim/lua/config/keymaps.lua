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
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

--New tab
keymap.set("n", "<Ctrl><tab>", ":tabedit<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)

--Split window
keymap.set("n", "<C-w><C-s>", ":split<Return>", opts)
keymap.set("n", "<C-w><C-v>", ":vsplit<Return>", opts)
--Move windows
keymap.set("n", "<A-w><A-n>", "<C-w>h", opts)
keymap.set("n", "<A-w><A-t>", "<C-w>j", opts)
keymap.set("n", "<A-w><A-s>", "<C-w>k", opts)
keymap.set("n", "<A-w><A-k>", "<C-w>l", opts)

--Resize window
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

keymap.set("i", "tst", "<Esc>", opts)
keymap.set("i", "<A-n>", "<Left>", opts)
keymap.set("i", "<A-t>", "<Down>", opts)
keymap.set("i", "<A-s>", "<Up>", opts)
keymap.set("i", "<A-k>", "<Right>", opts)
