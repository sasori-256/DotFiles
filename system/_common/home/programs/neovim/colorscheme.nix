{ ... }:

{
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
        render_markdown = true;
        snacks = {
          enabled = true;
          indent_scope_color = "mauve";
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
}
