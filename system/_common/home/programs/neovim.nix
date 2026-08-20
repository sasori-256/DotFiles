{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      autoformat = true;
      snacks_animate = false;
    };

    opts = {
      # Encoding / Edit
      encoding = "utf-8";
      fileencoding = "utf-8";
      fileencodings = [
        "utf-8"
        "ascii"
        "cp932"
        "euc-jp"
        "sjis"
      ];
      fileformats = [
        "dos"
        "unix"
      ]; # "mac" is deprecated after macOS-9
      backspace = [
        "indent"
        "eol"
        "start"
      ];
      clipboard = "unnamedplus";
      autoread = true;

      # Display
      number = true;
      relativenumber = true;
      title = true;
      ruler = true;
      cursorline = true;
      virtualedit = "onemore";
      showmatch = true; # Jump temporarily to the end of a bracket pair
      matchpairs = "(:),{:},[:],<:>,（:）,「:」,『:』,【:】,［:］,＜:＞";
      visualbell = true;
      whichwrap = "b,s,<,>,[,],"; # Not wrap by using h and l (in tomisuke keymap, n and k)
      wrap = false;
      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldlevelstart = 99;
      list = true; # Visualize following chars
      listchars = {
        eol = "↵";
        tab = "» ";
        trail = "•";
        extends = "…";
        precedes = "…";
        nbsp = "␣";
      };
      inccommand = "split"; # Show replacement preview include out of the window
      scrolloff = 5;
      sidescroll = 1;
      sidescrolloff = 8;

      # Tab / Indent
      expandtab = true;
      smarttab = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      autoindent = true;
      smartindent = false; # Avoid from conflicting with Treesitter indent
      # breakindent = true;  # Only works on wrap = true

      # Backup
      backup = false;
      swapfile = false;

      # Search
      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      wrapscan = true;

      # UI
      cmdheight = 0;
      laststatus = 3;
      splitbelow = true;
      splitright = true;
      splitkeep = "cursor";
    };

    keymaps = [
      # Disable dangerous exits
      {
        mode = "n";
        key = "ZZ";
        action = "<NOP>";
      }
      {
        mode = "n";
        key = "ZQ";
        action = "<NOP>";
      }

      # Edit
      {
        mode = "n";
        key = "+";
        action = "<C-a>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "-";
        action = "<C-x>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "Y";
        action = "y$";
        options = {
          noremap = true;
          silent = true;
          desc = "Yank from here on";
        };
      }
      {
        mode = "n";
        key = "U";
        action = "<C-r>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "x";
        action = "\"_x";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "X";
        action = "\"_X";
        options = {
          noremap = true;
          silent = true;
        };
      }

      # --- Tomisuke Layout ---

      # Basic keymaps
      {
        mode = [
          "n"
          "v"
        ];
        key = "n";
        action = "h";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "t";
        action = "gj";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "s";
        action = "gk";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "k";
        action = "l";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "H";
        action = "Nzz";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "h";
        action = "nzz";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "j";
        action = "\"_s";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "i";
        key = "hh";
        action = "<Esc>";
        options = {
          noremap = true;
          silent = true;
        };
      }

      # Window Move
      {
        mode = "n";
        key = "<C-n>";
        action = "<C-w>h";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to left window";
        };
      }
      {
        mode = "n";
        key = "<C-t>";
        action = "<C-w>j";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to lower window";
        };
      }
      {
        mode = "n";
        key = "<C-s>";
        action = "<C-w>k";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to upper window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>l";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to right window";
        };
      }

      # Window Resize
      {
        mode = "n";
        key = "<A-n>"; # Expand to the left / Narrow the right window
        action = "<cmd>vertical resize -2<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Resize window left";
        };
      }
      {
        mode = "n";
        key = "<A-t>"; # Expand downwards / Narrow upper window
        action = "<cmd>resize +2<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Resize window down";
        };
      }
      {
        mode = "n";
        key = "<A-s>"; # Expand upwards / Narrow lower window
        action = "<cmd>resize -2<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Resize window up";
        };
      }
      {
        mode = "n";
        key = "<A-k>"; # Expand to the right / Narrow the left window
        action = "<cmd>vertical resize +2<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Resize window right";
        };
      }

      # --- Leader: File ---
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua MiniFiles.open()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "File explorer";
        };
      }

      # --- Leader: Picker (Snacks) ---
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>lua Snacks.picker.files()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Find files";
        };
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua Snacks.picker.grep()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Live grep";
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.recent()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Recent files";
        };
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "LSP symbols";
        };
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Diagnostics";
        };
      }

      # --- Leader: Git ---
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>lua Snacks.lazygit()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Lazygit";
        };
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>lua Snacks.picker.git_log()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Git log";
        };
      }

      # --- Leader: LSP ---
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to definition";
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Show references";
        };
      }
      {
        mode = "n";
        key = "<leader>li";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to implementation";
        };
      }
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Signature help";
        };
      }

      # --- Leader: Window / Tab ---
      {
        mode = "n";
        key = "<leader>-";
        action = "<cmd>split<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Horizontal split";
        };
      }
      {
        mode = "n";
        key = "<leader>|";
        action = "<cmd>vsplit<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Vertical split";
        };
      }
      {
        mode = "n";
        key = "<leader>ww";
        action = "<cmd>tabnew<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "New tab";
        };
      }
      {
        mode = "n";
        key = "<leader>wc";
        action = "<cmd>tabclose<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Close tab";
        };
      }
      {
        mode = "n";
        key = "<leader>wn";
        action = "<cmd>tabnext<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Next tab";
        };
      }
      {
        mode = "n";
        key = "<leader>wp";
        action = "<cmd>tabprevious<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Previous tab";
        };
      }

      # --- Leader: Diagnostics (Trouble) ---
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Workspace diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>xd";
        action = "<cmd>Trouble diagnostics filter.buf=0<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Buffer diagnostics";
        };
      }

      # --- Leader: Notifications ---
      {
        mode = "n";
        key = "<leader>nh";
        action = "<cmd>lua Snacks.notifier.show_history()<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Notification history";
        };
      }
    ];

    # ===== Cholorscheme =====
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "frappe";
        background = {
          light = "latte";
          dark = "frappe";
        };
        transparent_background = true;
        float = {
          transparent = false;
          solid = true;
        };
        term_colors = true;

        dim_inactive = {
          enable = false;
          shade = "dark";
          percentage = 0.10;
        };

        styles = {
          comments = [ "italic" ];
          conditionals = [ "italic" ];
          keywords = [ "italic" ];
          functions = [ "bold" ];
          types = [ "bold" ];
          loops = [ ];
          strings = [ ];
          variables = [ ];
          numbers = [ ];
          booleans = [ ];
          properties = [ ];
          operators = [ ];
        };

        lsp_styles = {
          virtual_text = {
            errors = [ "italic" ];
            hints = [ "italic" ];
            warnings = [ "italic" ];
            information = [ "italic" ];
            ok = [ "italic" ];
          };
          underlines = {
            errors = [ "underline" ];
            hints = [ "underline" ];
            warnings = [ "underline" ];
            information = [ "underline" ];
            ok = [ "underline" ];
          };
          inlay_hints.background = true;
        };

        custom_highlights.__raw = ''
          function(colors)
            return {
              -- ウィンドウ区切りをアクセントカラーに
              WinSeparator    = { fg = colors.surface1 },

              -- 現在行番号を目立たせる
              CursorLineNr    = { fg = colors.mauve, bold = true },
              LineNr          = { fg = colors.overlay0 },

              -- フロートウィンドウの枠
              FloatBorder     = { fg = colors.blue, bg = "NONE" },
              NormalFloat     = { bg = "NONE" },

              -- 検索ハイライトをくっきり
              Search          = { bg = colors.yellow,  fg = colors.base, bold = true },
              IncSearch       = { bg = colors.peach,   fg = colors.base, bold = true },
              CurSearch       = { bg = colors.red,     fg = colors.base, bold = true },

              -- snacks picker / telescope の枠を統一
              SnacksPickerBorder = { fg = colors.surface1 },
            }
          end
        '';

        default_integrations = true;
        auto_integrations = false; # Only used by lazy.nvim

        integrations = {
          # 使用プラグインのみ明示
          blink_cmp = {
            style = "bordered";
          };
          fidget = true;
          flash = true;
          gitsigns = true;
          lsp_trouble = true;
          lualine = {
            transparent = false;
          };
          mini = {
            enabled = true;
            indentscope_color = "";
          };
          noice = true; # default is false
          notify = true; # default is false
          render_markdown = true;
          snacks = {
            enabled = true;
            indent_scope_color = "";
          };
          treesitter = true;
          treesitter_context = true;
          which_key = true; # default is  false

          # Never used
          nvimtree = false;
          alpha = false;
        };
      };
    };

    # ===== Plugins =====
    plugins = {
      # --- Treesitter ---
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          auto_install = false;
          ensure_installed = [
            "bash"
            "c"
            "cpp"
            "css"
            "html"
            "java"
            "javascript"
            "json"
            "lua"
            "luadoc"
            "markdown"
            "markdown_inline"
            "mdx"
            "nix"
            "python"
            "rust"
            "scheme"
            "toml"
            "tsx"
            "typescript"
            "vim"
            "vimdoc"
            "yaml"
            "query"
          ];
        };
      };

      # Show the head of a code block
      treesitter-context = {
        enable = true;
        settings.max_lines = 3;
      };

      # Enable to select and move code blocks
      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "<leader>taf" = "@function.outer";
              "<leader>tif" = "@function.inner";
              "<leader>tac" = "@class.outer";
              "<leader>tic" = "@class.inner";
              "<leader>tal" = "@loop.outer";
              "<leader>til" = "@loop.inner";
              "<leader>taa" = "@parameter.outer";
              "<leader>tia" = "@parameter.inner";
              "<leader>tas" = "@statement.outer";
            };
          };
          move = {
            enable = true;
            set_jumps = true;
            goto_next_start = {
              "]m" = "@function.outer";
              "]]" = "@class.outer";
            };
            goto_next_end = {
              "]M" = "@function.outer";
              "][" = "@class.outer";
            };
            goto_previous_start = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
            goto_previous_end = {
              "[M" = "@function.outer";
              "[]" = "@class.outer";
            };
          };
        };
      };

      # --- LSP ---
      lsp = {
        enable = true;
        servers = {
          ruff.enable = true;
          ts_ls.enable = true;
          clangd.enable = true;
          tailwindcss.enable = true;
          dockerls.enable = true;
          cmake.enable = true;
          yamlls.enable = true;
          jsonls.enable = true;
          sqls.enable = true;
          guile_ls = {
            enable = true;
            package = null;
          };
          jdtls = {
            enable = true;
            extraOptions = {
              # Per-project workspace: cache/jdtls/<project-name>
              cmd.__raw = ''
                {
                  "jdtls",
                  "--data=" .. vim.fn.stdpath("cache") .. "/jdtls/" ..
                    vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
                }
              '';
              settings.java.configuration.runtimes.__raw = ''
                (function()
                  local h = vim.fn.getenv("JAVA_HOME")
                  if h ~= vim.NIL and h ~= "" then
                    return {{ name = "JavaSE-25", path = h, default = true }}
                  end
                  return {}
                end)()
              '';
            };
          };
        };
      };

      lazydev.enable = true;
      fidget.enable = true;

      # --- Completion ---
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "none";

            "<S-Space>" = [
              "show"
              "show_documentation"
              "hide_documentation"
            ];
            "<Tab>" = [
              "accept"
              "fallback"
            ];
            "<C-t>" = [
              "select_next"
              "fallback"
            ]; # t = downwards
            "<C-s>" = [
              "select_prev"
              "fallback"
            ]; # s = upwards
            # Move placeholder when expanding snippet
            "<C-b>" = [
              "snippet_backward"
              "fallback"
            ];
            "<C-f>" = [
              "snippet_forward"
              "fallback"
            ];
          };
          appearance = {
            use_nvim_cmp_as_default = true;
            nerd_font_variant = "mono";
          };
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
      };

      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enable = true;
            auto_trigger = true;
            keymap = {
              accept = "<C-CR>";
              accept_line = false;
              accept_word = false;
              next = "<C-]>";
              prev = "<C-[>";
              dismiss = "<Esc>";
            };
          };
          panel.enable = false;
        };
      };

      # --- Formatter ---
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            javascript.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            typescript.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            javascriptreact.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            typescriptreact.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            css.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            json.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            jsonc.__raw = ''{ "biome", "prettierd", "prettier", stop_after_first = true }'';
            html.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
            yaml.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
            markdown.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
            mdx.__raw = ''{ "prettierd", "prettier", stop_after_first = true }'';
            python = [ "ruff_format" ];
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            scheme = [ "schemat" ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters = {
            schemat = {
              command = "schemat";
              stdin = true;
            };
          };
        };
      };

      # --- Linter ---
      lint = {
        enable = true;
        lintersByFt = {
          javascript = [
            "biome"
            "eslint"
          ];
          typescript = [
            "biome"
            "eslint"
          ];
          javascriptreact = [
            "biome"
            "eslint"
          ];
          typescriptreact = [
            "biome"
            "eslint"
          ];
          css = [ "biome" ];
          json = [ "biome" ];
          jsonc = [ "biome" ];
          html = [ "htmllint" ];
          yaml = [ "yamllint" ];
          markdown = [ "markdownlint" ];
          mdx = [
            "eslint"
          ];
          python = [ "ruff" ];
          lua = [ "selene" ];
          nix = [ "statix" ];
        };
      };

      # --- Snacks ---
      snacks = {
        enable = true;
        settings = {
          picker = {
            enable = true;
          };
          dashboard = {
            enable = true;
            preset.header = ''
              ███████╗██████╗ ███████╗ █████╗ ██╗  ██╗██╗
              ██╔════╝██╔══██╗██╔════╝██╔══██╗██║ ██╔╝██║
              ███████╗██████╔╝█████╗  ███████║█████╔╝ ██║
              ╚════██║██╔═══╝ ██╔══╝  ██╔══██║██╔═██╗ ██║
              ███████║██║     ███████╗██║  ██║██║  ██╗██║
              ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝
            '';
            sections = [
              {
                pane = 1;
                section = "terminal";
                cmd = "chafa ~/Downloads/supiki.webp --size 50 --symbols vhalf";
                height = 30;
                padding = 1;
                ttl = 300;
                indent = 3;
              }
              {
                pane = 1;
                __raw = ''
                  function()
                    local start = vim.g._start_time or vim.uv.hrtime()
                    local ms = (vim.uv.hrtime() - start) / 1e6
                    local v = vim.version()
                    return {{
                      text = {{
                        string.format(" v%d.%d.%d  |  ⏱  %.0fms  |  📅  %s",
                          v.major, v.minor, v.patch, ms, os.date("%Y-%m-%d")),
                        "SnacksDashboardFooter",
                      }},
                      align = "center",
                      padding = 1,
                    }}
                  end
                '';
              }
              {
                pane = 2;
                section = "header";
              }
              {
                pane = 2;
                section = "keys";
                gap = 1;
                padding = 1;
              }
              {
                pane = 2;
                section = "recent_files";
                cwd = true;
                padding = 1;
              }
              {
                pane = 2;
                section = "projects";
                padding = 1;
              }
            ];
          };
          notifier = {
            enable = true;
          };
          lazygit = {
            enable = true;
          };
          indent = {
            enable = false;
          };
          # mini.animate is now enabled by default, but it can be disabled if you want to use Snacks.animate instead
          scroll = {
            enable = false;
          };
          words = {
            enable = true;
          };
          bigfile = {
            enable = true;
          };
        };
      };

      # --- Noice ---
      noice = {
        enable = true;
        settings = {
          presets = {
            lsp_doc_border = true;
          };
          routes = [
            {
              filter = {
                event = "notify";
                find = "No information available";
              };
              opts = {
                skip = true;
              };
            }
          ];
          lsp = {
            override = {
              # Override vim's markdown rendering to use Noice's, so that it can be themed by catppuccin and also support more features like keymaps in the future
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
            };
          };
        };
      };

      notify = {
        enable = true;
        settings = {
          timeout = 10000;
        };
      };

      # --- Lualine ---
      lualine = {
        enable = true;
        settings.options = {
          theme = "catppuccin-frappe";
          globalstatus = true;
        };
      };

      which-key = {
        enable = true;
      };

      render-markdown = {
        # "completion" is deprecated
        enable = true;
        settings = {
          latex.enabled = false;
        };
      };

      # --- Git ---
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add.text = "┃";
            change.text = "┃";
            delete.text = " ";
            topdelete.text = "‾";
            changedelete.text = "~";
            untracked.text = "│";
          };
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
            delay = 3000;
            ignore_whitespace = true;
          };
          preview_config = {
            border = "rounded";
            style = "minimal";
            relative = "cursor";
          };
        };
      };

      # --- Navigation / Editor ---
      flash = {
        enable = true;
      };

      trouble = {
        enable = true;
        settings = {
          mode = "diagnostic"; # "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "lsp_definitions", "lsp_implementations", "lsp_type_definitions", "lsp_calls"
        };
      };

      todo-comments = {
        enable = true;
      };

      # --- Indent Guide ---
      hlchunk = {
        enable = true;
        settings = {
          chunk = {
            enable = true;
            use_treesitter = true;
            delay = 0;
            duration = 0;
            style = [
              { fg = "#ca9ee6"; }
              { fg = "#c6d0f5"; }
            ];
            chars = {
              horizontal_line = "─";
              vertical_line = "│";
              left_top = "╭";
              left_bottom = "╰";
              right_arrow = "─";
            };
          };
          indent = {
            enable = true;
            chars = [ " " ];
            style = [
              { fg = "#51576d"; }
            ];
          };
          line_num.enable = false;
          blank.enable = false;
        };
      };
      #
      # --- Mini ---
      mini = {
        enable = true;
        mockDevIcons = true; # For testing without nerdfonts
        modules = {
          files = {
            windows.preview = true;
            mappings = {
              go_in = "k";
              go_in_plus = "K";
              go_out = "n";
              go_out_plus = "N";
            };
          };
          icons = { };
          surround = {
            n_lines = 500;
          };
          ai = { };
          pairs = { };
          animate = { };
          hipatterns = {
            # highlighters = {
            #   fixme = {
            #     pattern = "%f[%w]()FIXME()%f[%W]";
            #     group = "MiniHipatternsFixme";
            #   };
            #   hack = {
            #     pattern = "%f[%w]()HACK()%f[%W]";
            #     group = "MiniHipatternsHack";
            #   };
            #   todo = {
            #     pattern = "%f[%w]()TODO()%f[%W]";
            #     group = "MiniHipatternsTodo";
            #   };
            #   note = {
            #     pattern = "%f[%w]()NOTE()%f[%W]";
            #     group = "MiniHipatternsNote";
            #   };
            # };
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
    ];

    extraConfigLuaPre = "vim.g._start_time = vim.uv.hrtime()";

    extraConfigLua = ''
      vim.filetype.add({ extension = { mdx = "mdx" } })
      vim.treesitter.language.register("markdown", "mdx")

      -- vsplit時のスクロールティア修正:
      -- Neovimのターミナルスクロール最適化(DECSTBM+CSI S/T)は画面全幅に適用されるため、
      -- 縦分割時に非アクティブウィンドウの表示が崩れる。
      -- スクロール毎に強制再描画して修正する。
      local _in_redraw = false
      vim.api.nvim_create_autocmd("WinScrolled", {
        callback = function()
          if _in_redraw then return end
          local cur = vim.api.nvim_get_current_win()
          for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if w ~= cur and vim.api.nvim_win_get_config(w).relative == "" then
              _in_redraw = true
              vim.cmd("redraw!")
              _in_redraw = false
              return
            end
          end
        end,
      })
    '';
  };
}
