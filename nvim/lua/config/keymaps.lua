-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Turn off no-comandline exit
keymap.set("n", "ZZ", "<NOP>")
keymap.set("n", "ZQ", "<NOP>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

-- Scroll
-- keymap.set("n", "<Up>", "<C-y>", opts)
-- keymap.set("n", "<Down>", "<C-e>", opts)

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

-- Yank following sentence in a row
keymap.set("n", "Y", "y$")

-- Redo
keymap.set("n", "U", "<C-r>", opts)

-- Delete without overwrite clipboard
keymap.set("n", "x", '"_x', opts)
keymap.set("n", "X", '"_X', opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
-- keymap.set("n", "<tab>e", ":tabedit<Return>", opts)
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)

--Split window
keymap.set("n", "<C-w><C-s>", ":split<Return>", opts)
keymap.set("n", "<C-w><C-v>", ":vsplit<Return>", opts)

--Move splited windows
keymap.set("n", "<A-w><A-n>", "<C-w>h", opts)
keymap.set("n", "<A-w><A-t>", "<C-w>j", opts)
keymap.set("n", "<A-w><A-s>", "<C-w>k", opts)
keymap.set("n", "<A-w><A-k>", "<C-w>l", opts)

--Resize window
keymap.set("n", "<C-w><Left>", "<C-w><")
keymap.set("n", "<C-w><Right>", "<C-w>>")
keymap.set("n", "<C-w><Up>", "<C-w>+")
keymap.set("n", "<C-w><Down>", "<C-w>-")

--Diagnostic
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

--Set Tomisuke
keymap.set("n", "<A-n>", "<C-w>h", opts)
keymap.set("n", "<A-t>", "<C-w>j", opts)
keymap.set("n", "<A-s>", "<C-w>k", opts)
keymap.set("n", "<A-k>", "<C-w>l", opts)
keymap.set("n", "H", "Nzz", opts)
keymap.set("n", "h", "nzz", opts)
keymap.set({ "n", "v" }, "n", "h", opts)
keymap.set({ "n", "v" }, "t", "gj", opts)
keymap.set({ "n", "v" }, "s", "gk", opts)
keymap.set({ "n", "v" }, "k", "l", opts)
keymap.set("n", "j", '"_s', opts)

keymap.set("i", "hh", "<Esc>", opts)
keymap.set("i", "<A-n>", "<Left>", opts)
keymap.set("i", "<A-t>", "<Down>", opts)
keymap.set("i", "<A-s>", "<Up>", opts)
keymap.set("i", "<A-k>", "<Right>", opts)

-- Gemini
local gemini = require("utils.gemini")
keymap.set("n", "<leader>ga", gemini.ask, { desc = "Ask Gemini" })
keymap.set("v", "<leader>ga", gemini.visual_action, { desc = "Ask Gemini about selection" })
keymap.set("n", "<leader>gc", gemini.chat, { desc = "Chat with Gemini" })
keymap.set("n", "<leader>gq", ":GeminiChatEnd<CR>", { desc = "Quit Gemini Chat" })
