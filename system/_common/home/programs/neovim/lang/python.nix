{ lib, ... }:

let
  inherit (import ../lib.nix { inherit lib; }) nmap cmd luaCmd;
in
{
  # wezterm comes from the Homebrew cask (darwin/_common/system.nix)
  dependencies.wezterm.enable = false;

  plugins = {
    treesitter.settings.ensure_installed = [ "python" ];

    lsp.servers.ruff.enable = true;

    conform-nvim.settings.formatters_by_ft.python = [ "ruff_format" ];
    lint.lintersByFt.python = [ "ruff" ];

    # Open an ipynb as a "# %%" .py and write it back to ipynb on save
    jupytext.enable = true;

    # Move between / run "# %%" cells
    notebook-navigator.enable = true;

    # Run code on a Jupyter kernel and show the output (and figures) in the buffer
    wezterm.enable = true;
    molten = {
      enable = true;
      settings = {
        image_provider = "wezterm";
        # The wezterm image provider does not support auto_open_output
        auto_open_output = false;
        virt_text_output = true;
      };
    };
  };

  keymaps = [
    (nmap "<S-CR>" (luaCmd "require('notebook-navigator').run_and_move()") "Run cell and move to next")
    (nmap "<leader>mi" (cmd "MoltenInit") "Molten: init kernel")
    (nmap "<leader>ml" (cmd "MoltenEvaluateLine") "Molten: run line")
    (nmap "<leader>mr" (cmd "MoltenReevaluateCell") "Molten: rerun cell")
    (nmap "<leader>mo" (cmd "MoltenEnterOutput") "Molten: open output")
    (nmap "<leader>mp" (cmd "MoltenImagePopup") "Molten: show image")
  ];
}
