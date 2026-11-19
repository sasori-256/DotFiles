{ ... }:

{
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
          "cmake"
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
  };

  extraConfigLua = ''
    vim.filetype.add({ extension = { mdx = "mdx" } })
    vim.treesitter.language.register("markdown", "mdx")
  '';
}
