local wezterm = require 'wezterm'

-- tabline.wez
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    theme = "Catppuccin Frappe" ,
    tabs_enabled = true,
    color_overrides = {},
    section_separators = {
      left = "",
      right = "",
    },
    component_separators = {
      left = "",
      right = "",
    },
    tab_separators = {
      left = "",
      right = "",
    },
  },
  sections = {
    tabline_a = {
      {
        'mode',
      },
    },
    tab_active = {
      'index',
      { 'process', icons_only = true, padding = 0 },
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      max_length = 10,
      { 'zoomed', padding = 0 },
    },
    tab_inactive = {
      'index',
      { 'process', icons_only = true, padding = 0 },
      { 'cwd', padding = { left = 0, right = 1 } },
      max_length = 5,
      { 'zoomed', padding = 0 },
    },
    tabline_x = {
      'cpu',
      'ram',
      throttle = 5, -- How often in seconds the component updates, set to 0 to disable throttling
    },
    tabline_y = {
      'battery',
      'datetime',
      style = '%H:%M',
      -- hour_to_icon = {
      --   ['00'] = wezterm.nerdfonts.md_clock_time_twelve_outline,
      --   ['01'] = wezterm.nerdfonts.md_clock_time_one_outline,
      --   ['02'] = wezterm.nerdfonts.md_clock_time_two_outline,
      --   ['03'] = wezterm.nerdfonts.md_clock_time_three_outline,
      --   ['04'] = wezterm.nerdfonts.md_clock_time_four_outline,
      --   ['05'] = wezterm.nerdfonts.md_clock_time_five_outline,
      --   ['06'] = wezterm.nerdfonts.md_clock_time_six_outline,
      --   ['07'] = wezterm.nerdfonts.md_clock_time_seven_outline,
      --   ['08'] = wezterm.nerdfonts.md_clock_time_eight_outline,
      --   ['09'] = wezterm.nerdfonts.md_clock_time_nine_outline,
      --   ['10'] = wezterm.nerdfonts.md_clock_time_ten_outline,
      --   ['11'] = wezterm.nerdfonts.md_clock_time_eleven_outline,
      --   ['12'] = wezterm.nerdfonts.md_clock_time_twelve_outline,
      --   ['13'] = wezterm.nerdfonts.md_clock_time_one_outline,
      --   ['14'] = wezterm.nerdfonts.md_clock_time_two_outline,
      --   ['15'] = wezterm.nerdfonts.md_clock_time_three_outline,
      --   ['16'] = wezterm.nerdfonts.md_clock_time_four_outline,
      --   ['17'] = wezterm.nerdfonts.md_clock_time_five_outline,
      --   ['18'] = wezterm.nerdfonts.md_clock_time_six_outline,
      --   ['19'] = wezterm.nerdfonts.md_clock_time_seven_outline,
      --   ['20'] = wezterm.nerdfonts.md_clock_time_eight_outline,
      --   ['21'] = wezterm.nerdfonts.md_clock_time_nine_outline,
      --   ['22'] = wezterm.nerdfonts.md_clock_time_ten_outline,
      --   ['23'] = wezterm.nerdfonts.md_clock_time_eleven_outline,
      -- },
    },
    tabline_z = {
      'domain',
    },
  },
})
