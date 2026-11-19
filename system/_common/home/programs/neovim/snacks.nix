{ ... }:

{
  keymaps = [
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

  plugins = {
    # --- Snacks ---
    snacks = {
      enable = true;
      settings = {
        picker = {
          enable = true;
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
  };
}
