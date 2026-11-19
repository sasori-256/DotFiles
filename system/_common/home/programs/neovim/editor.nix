{ ... }:

{
  keymaps = [
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
  ];

  plugins = {
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
}
