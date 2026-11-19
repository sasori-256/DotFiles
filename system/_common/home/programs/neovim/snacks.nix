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
