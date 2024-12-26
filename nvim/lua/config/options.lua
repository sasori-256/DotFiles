-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-------------------------------------------------------------------------------
-- Basic
-------------------------------------------------------------------------------
local opt = vim.opt

vim.g.mapleader = " "

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8", "ascii", "cp932", "euc-jp", "sjis"}
opt.fileformats = { "dos", "unix" }
opt.ambiwidth = "single"
opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"

-------------------------------------------------------------------------------
-- Display
-------------------------------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.title = true
opt.ruler = true
opt.cursorline = true
-- opt.colorcolumn = "+80"
opt.virtualedit = "onemore"
opt.showmatch = true
-- opt.matchpairs =  "<:>, （:）, 「:」, 『:』, 【:】, ［:］, ＜:＞"
opt.visualbell = true
opt.whichwrap = "b,s,<,>"
opt.wrap = false
-- opt.linebreak = true
-- opt.showbreak = "=>>>"
opt.foldmethod = "syntax"
opt.foldlevelstart = 99
opt.listchars = { eol = '↵', tab = '>~', trail = '-', extends = '>', precedes = '<', nbsp = '%' }
opt.list = true

-------------------------------------------------------------------------------
-- Tab
-------------------------------------------------------------------------------
opt.expandtab = true
opt.smarttab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true

-------------------------------------------------------------------------------
-- Backup
-------------------------------------------------------------------------------
opt.backup = false
opt.swapfile = false

-------------------------------------------------------------------------------
-- Search
-------------------------------------------------------------------------------
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.autoread = true

-------------------------------------------------------------------------------
-- Menu
-------------------------------------------------------------------------------
-- opt.wildmenu = true
-- opt.wildmode 
opt.cmdheight = 1
opt.laststatus = 3

-------------------------------------------------------------------------------
-- Split
-------------------------------------------------------------------------------
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "cursor"

vim.opt.mouse = ""

-- Undercurl
--vim.cmd([[let &t_Cs = "\e[4:3m"]])
--vim.cmd([[let &t_Ce = "\e[4:0m"]])
