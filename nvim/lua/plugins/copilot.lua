return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,

  init = function()
    local home = vim.env.HOME or vim.env.USERPROFILE
    local auth_path = home .. "/.codex/auth.json"

    local function load_key()
      local file = io.open(auth_path, "r")
      if not file then
        return nil
      end
      local content = file:read("*a")
      file:close()

      local token = content:match('"token"%s*:%s*"(.-)"')
        or content:match('"api_key"%s*:%s*"(.-)"')
        or content:match('"access_token"%s*:%s*"(.-)"')
      return token
    end

    local key = load_key()
    if key then
      vim.env.OPENAI_API_KEY = key
    end
  end,

  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",

    providers = {
      -- プロバイダー詳細設定
      copilot = {
        timeout = 60000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 65535,
          max_completion_tokens = 32767,
          reasoning_effort = "high", -- Option: low, medium, high, xhigh
        },
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-5.2",
        timeout = 60000,

        extra_request_body = {
          temperature = 0,
          max_tokens = 65535,
          max_completion_tokens = 32767,
          reasoning_effort = "high", -- Option: low, medium, high, xhigh
        },
      },
    },

    acp_providers = {
      ["codex"] = {
        command = "pnpm",
        args = { "dlx", "@zed-industries/codex-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          OPENAI_API_KEY = vim.env.OPENAI_API_KEY,
        },
      },
    },

    behaviour = {
      auto_suggestions = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua", -- for providers='copilot'
  },
}
