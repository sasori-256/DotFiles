-- Pull in the wezterm API
local wezterm = require("wezterm")
-- Pull Nerd  font
local nerd_font = require("wezterm").font("Moralerspace Neon NF")

-- This table will hold the configuration.
local config = {}

-- Pull files
local keybinds = require("keybinds")
require("format")
-- require 'status'
require("event")
require("tabline")

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Windows の場合は PowerShell を指定
	config.default_prog = { "pwsh.exe", "-NoLogo" }
else
	-- 他の OS (例: Linux/macOS) の場合は bash を指定
	config.default_prog = { "/usr/sbin/fish" }
end

-- config.default_prog = { 'wsl', '-d', 'Arch' }
config.color_scheme = "Catppuccin Frappe"
config.font = nerd_font
config.font_size = 20.0
-- config.window_decorations = 'RESIZE'
-- config.window_frame = {
--   font = wezterm.font { family = 'Roboto', weight = 'Bold' },
--   font_size = 10.0,
-- }
config.window_background_opacity = 0.85

-- Tab Bar
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.tab_max_width = 30

config.status_update_interval = 1000

config.disable_default_key_bindings = true
config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 1500 }
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

-- config.mouse_bindings = require('mousebinds').mouse_bindings

return config
