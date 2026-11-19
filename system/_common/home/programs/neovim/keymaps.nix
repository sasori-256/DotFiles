{ ... }:

{
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
  ];
}
