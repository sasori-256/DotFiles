{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      autoformat = true;
      snacks_animate = true;
    };

    opts = {
      # Encoding / Edit
      encoding = "utf-8";
      fileencoding = "utf-8";
      fileencodings = [ "utf-8" "ascii" "cp932" "euc-jp" "sjis" ];
      fileformats = [ "dos" "unix" ];  # "mac" is deprecated after macOS-9
      backspace = [ "indent" "eol" "start" ];
      clipboard = "unnamedplus";
      autoread = true;

      # Display
      number = true;
      relativenumber = true;
      title = true;
      ruler = true;
      cursorline = true;
      virtualedit = "onemore";
      showmatch = true;  # Jump temporarily to the end of a bracket pair
      matchpairs = "(:),{:},[:],<:>,（:）,「:」,『:』,【:】,［:］,＜:＞";
      visualbell = true;
      whichwrap = "b,s,<,>,[,],";  # Not wrap by using h and l (in tomisuke keymap, n and k)
      wrap = false;
      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldlevelstart = 99;
      list = true;  # Visualize following chars
      listchars = { eol = "↵"; tab = "» "; trail = "•"; extends = "…"; precedes = "…"; nbsp = "␣"; };
      inccommand = "split";  # Show replacement preview include out of the window
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
      smartindent = false;  # Avoid from conflicting with Treesitter indent
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
      splitkeep = "screen";
    };

    keymaps = [
      # Disable dangerous exits
      { mode = "n"; key = "ZZ"; action ="<NOP>"; }
      { mode = "n"; key = "ZQ"; action ="<NOP>"; }

      # Edit
      { mode = "n"; key = "+"; action ="<C-a>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "-"; action ="<C-x>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "Y"; action = "y$"; options = { noremap = true; silent = true; desc = "Yank from here on"; }; }
      { mode = "n"; key = "U"; action = "<C-r>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "x"; action = '''"_x''; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "X"; action = '''"_X''; options = { noremap = true; silent = true; }; }

      # ===== Tomisuke Layout =====

      # Basic keymaps
      { mode = [ "n" "v" ]; key = "n"; action = "h";  options = { noremap = true; silent = true; }; }
      { mode = [ "n" "v" ]; key = "t"; action = "gj"; options = { noremap = true; silent = true; }; }
      { mode = [ "n" "v" ]; key = "s"; action = "gk"; options = { noremap = true; silent = true; }; }
      { mode = [ "n" "v" ]; key = "k"; action = "l";  options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "H"; action = "Nzz"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "h"; action = "nzz"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "j"; action = '''"_s''; options = { noremap = true; silent = true; }; }
      { mode = "i"; key = "hh";   action = "<Esc>";  options = { noremap = true; silent = true; }; }

      # Window Move
      {
        mode = "n";
        key = "<C-n>";
        action = "<C-w>h";
        options = { noremap = true; silent = true; desc = "Go to left window"; };
      }
      {
        mode = "n";
        key = "<C-t>";
        action = "<C-w>j";
        options = { noremap = true; silent = true; desc = "Go to lower window"; };
      }
      {
        mode = "n";
        key = "<C-s>";
        action = "<C-w>k";
        options = { noremap = true; silent = true; desc = "Go to upper window"; };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>l";
        options = { noremap = true; silent = true; desc = "Go to right window"; };
      }

      # Window Resize
      {
        mode = "n";
        key = "<A-n>";  # Expand to the left / Narrow the right window
        action = "<cmd>vertical resize -2<CR>";
        options = { noremap = true; silent = true; desc = "Resize window left"; };
      }
      {
        mode = "n";
        key = "<A-t>";  # Expand downwards / Narrow upper window
        action = "<cmd>resize +2<CR>";
        options = { noremap = true; silent = true; desc = "Resize window down"; };
      }
      {
        mode = "n";
        key = "<A-s>";  # Expand upwards / Narrow lower window
        action = "<cmd>resize -2<CR>";
        options = { noremap = true; silent = true; desc = "Resize window up"; };
      }
      {
        mode = "n";
        key = "<A-k>";  # Expand to the right / Narrow the left window
        action = "<cmd>vertical resize +2<CR>";
        options = { noremap = true; silent = true; desc = "Resize window right"; };
      }
    ];
  };
}
