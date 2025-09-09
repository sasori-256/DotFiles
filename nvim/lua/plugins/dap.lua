return {
  -- DAPの基本的な設定はdap.core extraが行うため、ここでは追加設定のみ

  -- nvim-dap本体の設定
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts) -- config関数で既存の設定に追記
      local dap = require("dap")

      -- Python用の設定
      -- :Masonでdebugpyをインストールしておくこと
      dap.adapters.python = {
        type = "executable",
        command = "python3", -- 環境に合わせてpython3などに変更
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}", -- 現在のファイルでデバッグを開始
        },
      }

      -- Node.js / TypeScript / JavaScript用の設定
      -- :Masonでnode-debug2-adapterをインストールしておくこと
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }
      dap.configurations.javascript = {
        {
          name = "Launch file",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "internalConsole",
        },
      }
      -- TypeScriptもJavaScriptと同じ設定を流用
      dap.configurations.typescript = dap.configurations.javascript
    end,
  },

  -- DAP UIの見た目をカスタマイズ
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
    },
  },
}