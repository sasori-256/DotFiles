{ ... }:

{
  plugins = {
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
  };

  extraConfigLua = ''
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
}
