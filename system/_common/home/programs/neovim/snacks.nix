{ lib, ... }:

let
  inherit (import ./lib.nix { inherit lib; }) nmap luaCmd;
in
{
  keymaps = [
    # --- Leader: Picker (Snacks) ---
    (nmap "<leader><leader>" (luaCmd "Snacks.picker.files()") "Find files")
    (nmap "<leader>/" (luaCmd "Snacks.picker.grep()") "Live grep")
    (nmap "<leader>fb" (luaCmd "Snacks.picker.buffers()") "Buffers")
    (nmap "<leader>fr" (luaCmd "Snacks.picker.recent()") "Recent files")
    (nmap "<leader>fs" (luaCmd "Snacks.picker.lsp_symbols()") "LSP symbols")
    (nmap "<leader>fd" (luaCmd "Snacks.picker.diagnostics()") "Diagnostics")

    # --- Leader: Git ---
    (nmap "<leader>gg" (luaCmd "Snacks.lazygit()") "Lazygit")
    (nmap "<leader>gl" (luaCmd "Snacks.picker.git_log()") "Git log")

    # --- Leader: Notifications ---
    (nmap "<leader>nh" (luaCmd "Snacks.notifier.show_history()") "Notification history")
  ];

  plugins = {
    # --- Snacks ---
    snacks = {
      enable = true;
      settings = {
        picker = {
          enabled = true;
        };
        notifier = {
          enabled = true;
        };
        lazygit = {
          enabled = true;
        };
        # Show only the current code chunk, without indent guides
        indent = {
          enabled = true;
          indent.enabled = false;
          animate.enabled = false;
          chunk = {
            enabled = true;
            char = {
              corner_top = "╭";
              corner_bottom = "╰";
              arrow = "─";
            };
          };
        };
        # mini.animate is now enabled by default, but it can be disabled if you want to use Snacks.animate instead
        scroll = {
          enabled = false;
        };
        words = {
          enabled = true;
        };
        bigfile = {
          enabled = true;
        };
      };
    };
  };
}
