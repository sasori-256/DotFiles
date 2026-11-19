{ ... }:

{
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
}
