{ lib, ... }:

let
  inherit (import ../lib.nix { inherit lib; }) nmap cmd;
in
{
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
        auto_open_output = true;
        virt_text_output = true;
      };
    };
  };

  keymaps = [
    (nmap "<leader>mi" (cmd "MoltenInit") "Molten: init kernel")
    (nmap "<leader>ml" (cmd "MoltenEvaluateLine") "Molten: run line")
    (nmap "<leader>mr" (cmd "MoltenReevaluateCell") "Molten: rerun cell")
    (nmap "<leader>mo" (cmd "MoltenEnterOutput") "Molten: open output")
  ];
}
