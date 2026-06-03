return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "make",
      "python",
      "rust",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      "query",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["<leader>taf"] = "@function.outer",
            ["<leader>tif"] = "@function.inner",
            ["<leader>tac"] = "@class.outer",
            ["<leader>tic"] = "@class.inner",
            ["<leader>tal"] = "@loop.outer",
            ["<leader>til"] = "@loop.inner",
            ["<leader>taa"] = "@parameter.outer",
            ["<leader>tia"] = "@parameter.inner",
            ["<leader>tas"] = "@statement.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>tsa"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>tsA"] = "@parameter.inner",
          },
        },
      },
    },
  },
}
