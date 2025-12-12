return {
  -- lsp icons like vscode
  {
    "onsails/lspkind.nvim",
    -- nvim-cmp.lua
    event = "InsertEnter",
  },
  -- mason.nvim and mason-lspconfig.nvim
  {
    "mason-org/mason.nvim",
    version = "*",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
      },
    },
    config = true,
  },
  -- mason-lspconfig configuration
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = { -- インストールを保証するサーバー
        "jdtls",
      },
    }
    config = true,
  },
  -- jdtls configuration via nvim-lspconfig opts
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          vmargs = {
            "-Dfile.encoding=UTF-8",
          }
          settings = {
            java = {
              -- 基本設定
              signatureHelp = { enabled = true }, -- 引数のヒントを有効化
              contenntProvider = { enabled = true }, -- 定義ジャンプ時にソースコードを表示

              -- プロジェクト設定
              project = {
                resourceConfiguration = {
                  filter = {
                    "node_modules/**",
                    ".git/**",
                  }
                }
              }

              -- 補完設定
              conmletion = {
                -- staticメソッドやフィールドを補完候補の上位に表示
                favoriteStaticMembers = {
                  "org.junit.Assert.*",
                  "org.junit.Assume.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "org.junit.jupiter.api.Assumptions.*",
                  "org.mockito.Mockito.*",
                  "org.mockito.ArgumentMatchers.*",
                  "org.mockito.Answers.*",
                },
                -- 補完候補から除外する型
                filteredTypes = {
                  -- "com.sun.*",
                  -- "java.awt.*",
                  -- "jdk.*",
                  -- "sun.*",
                },
                importOrder = {
                  "java",
                  "javax",
                  "com",
                  "org",
                  "net",
                  "io",
                  "dev",
                },
              }

              -- import整理の設定
              sources = {
                organizeImports = {
                  starThreshold = 9999, -- インポートを*にまとめる閾値
                  staticStarThreshold = 9999, -- staticインポートを*にまとめる閾値
                },
              },

              -- コード生成の設定
              codeGeneration = {
                toString = {
                  -- toStringメソッドのテンプレート設定
                  template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true, -- コード生成時にif文などでブロックを使用
              }

              -- インレイヒントの設定
              inlayHints = {
                parameterNames = {
                  enabled = "all", -- 常にパラメータ名のインレイヒントを表示
                },
              }

              -- ランタイム設定
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-25",
                    path = "C:\\Program Files\\Microsoft\\jdk-25.0.0.36-hotspot",
                    default = true,
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
