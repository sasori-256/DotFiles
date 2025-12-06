return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "frappe",
    background = {
      light = "latte",
      dark = "frappe",
    },
    transparent_background = true, -- Background trancparency
    term_colors = true,
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      fzf = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },

  specs = {
    {
      "akinsho/bufferline.nvim",
      version = "*",
      event = "VeryLazy",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      optional = true,
      opts = function(_, opts)
        if (vim.g.colors_name or ""):find("catppuccin") then
          local ok, mod = pcall(require, "catppuccin.groups.integrations.bufferline")
          if ok then
            local get = mod.get_theme or mod.get
            if type(get) == "function" then
              opts.highlights = get({})
            end
          end
        end
      end,
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },
}
