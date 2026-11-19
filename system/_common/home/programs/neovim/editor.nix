{ lib, ... }:

let
  inherit (import ./lib.nix { inherit lib; })
    dir
    nmap
    cmd
    luaCmd
    ;
in
{
  keymaps = [
    # --- Leader: File ---
    (nmap "<leader>e" (luaCmd "MiniFiles.open()") "File explorer")

    # --- Leader: Diagnostics (Trouble) ---
    (nmap "<leader>xx" (cmd "Trouble diagnostics") "Workspace diagnostics")
    (nmap "<leader>xd" (cmd "Trouble diagnostics filter.buf=0") "Buffer diagnostics")
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
        # s and <c-s> collide with up / window-up in the Tomisuke layout
        keys = {
          s = false;
          "<c-s>" = false;
          "<c-v>" = false;
          "-" = "jump_split";
          "|" = "jump_vsplit";
          # Same as trouble's default s
          S = {
            action.__raw = ''
              function(view)
                local f = view:get_filter("severity")
                local severity = ((f and f.filter.severity or 0) + 1) % 5
                view:filter({ severity = severity }, {
                  id = "severity",
                  template = "{hl:Title}Filter:{hl} {severity}",
                  del = severity == 0,
                })
              end
            '';
            desc = "Toggle Severity Filter";
          };
        };
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
            go_in = dir.right;
            go_in_plus = lib.toUpper dir.right;
            go_out = dir.left;
            go_out_plus = lib.toUpper dir.left;
          };
        };
        icons = { };
        surround = {
          n_lines = 500;
          # The default s-prefix collides with s (up) in the Tomisuke layout
          mappings = {
            add = "gsa";
            delete = "gsd";
            replace = "gsr";
            find = "gsf";
            find_left = "gsF";
            highlight = "gsh";
            update_n_lines = "gsn";
          };
        };
        ai = { };
        pairs = { };
        animate = {
          # Scroll animation restores the pre-scroll view first, so a held { / }
          # keeps jumping to the same target and never gets past it
          scroll.enable = false;
        };
      };
    };
  };
}
