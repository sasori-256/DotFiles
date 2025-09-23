return {
  {
    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "windwp/nvim-ts-autotag",
    },
    main = "nvim-treesitter.configs",
    install = function()
      require("nvim-treesitter.install").setup({
        prefer_git = false,
        compilers = { "gcc" },
      })
    end,
    opts = {
      ensure_installed = {
        "bash",
        "dart",
        "fish",
        "gitignore",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "sql",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extention = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "CursorMoved",
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "xml",
        "php",
        "markdown",
        "mdx",
      },
    },
  },
}
