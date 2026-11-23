{ lib, ... }:

let
  inherit (import ./lib.nix { inherit lib; }) dir nmap luaCmd;

  # Picker window keys in the Tomisuke layout. The key spelling must match
  # snacks' defaults (lowercase <c-x>) for an override or `false` to apply.
  pickerKeys =
    inInsert:
    let
      act =
        a:
        if inInsert then
          {
            __unkeyed-1 = a;
            mode = [
              "i"
              "n"
            ];
          }
        else
          a;
    in
    {
      j = false;
      k = false;
      ${dir.down} = "list_down";
      ${dir.up} = "list_up";
      "<c-j>" = false;
      "<c-k>" = false;
      "<c-${dir.down}>" = act "list_down";
      "<c-${dir.up}>" = act "list_up";
      # <c-t> / <c-s> are taken by list movement above
      "<c-x>" = act "edit_split";
      "<c-cr>" = act "tab";
    };
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
          win = {
            input.keys = pickerKeys true;
            list.keys = pickerKeys false;
          };
        };
        notifier = {
          enabled = true;
          timeout = 10000;
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
        # Used instead of mini.animate's scroll, which gets stuck on a held { / }
        scroll = {
          enabled = true;
          # Animation for repeated scrolls (e.g. a held key). Keep it shorter than
          # the key repeat interval (macOS KeyRepeat = 2 is 30ms) or presses get lost.
          animate_repeat.duration = {
            step = 5;
            total = 20;
          };
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
