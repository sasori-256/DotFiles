{ ... }:

{
  plugins = {
    # --- LSP ---
    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        lspBuf = {
          "<leader>ld" = {
            action = "definition";
            desc = "Go to definition";
          };
          "<leader>lr" = {
            action = "references";
            desc = "Show references";
          };
          "<leader>li" = {
            action = "implementation";
            desc = "Go to implementation";
          };
          "<leader>ls" = {
            action = "signature_help";
            desc = "Signature help";
          };
        };
      };
    };

    fidget.enable = true;

    # --- Formatter ---
    conform-nvim = {
      enable = true;
      settings = {
        # Run only the first available formatter in each list
        default_format_opts.stop_after_first = true;
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
      };
    };

    # --- Linter ---
    lint.enable = true;
  };

  extraConfigLua = ''
    -- LSP inlay hints
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true)
    end
  '';
}
