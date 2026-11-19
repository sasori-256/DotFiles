{ lib, ... }:

let
  inherit (import ./lib.nix { inherit lib; })
    dir
    vimDir
    map
    nmap
    cmd
    ;

  # Modifiers for window focus / resize
  moveMod = "C";
  resizeMod = "A";

  motion = {
    left = "h";
    down = "gj";
    up = "gk";
    right = "l";
  };
  resize = {
    left = "vertical resize -2"; # Expand to the left / Narrow the right window
    down = "resize +2"; # Expand downwards / Narrow upper window
    up = "resize -2"; # Expand upwards / Narrow lower window
    right = "vertical resize +2"; # Expand to the right / Narrow the left window
  };
in
{
  keymaps = [
    # Disable dangerous exits
    (nmap "ZZ" "<NOP>" null)
    (nmap "ZQ" "<NOP>" null)

    # Edit
    (nmap "+" "<C-a>" null)
    (nmap "-" "<C-x>" null)
    (nmap "Y" "y$" "Yank from here on")
    (nmap "U" "<C-r>" null)
    (nmap "x" "\"_x" null)
    (nmap "X" "\"_X" null)

    # --- Tomisuke Layout ---
    (nmap "H" "Nzz" null)
    (nmap "h" "nzz" null)
    (nmap "j" "\"_s" null)
    (map "i" "hh" "<Esc>" null)

    # --- Leader: Window / Tab ---
    (nmap "<leader>-" (cmd "split") "Horizontal split")
    (nmap "<leader>|" (cmd "vsplit") "Vertical split")
    (nmap "<leader>ww" (cmd "tabnew") "New tab")
    (nmap "<leader>wc" (cmd "tabclose") "Close tab")
    (nmap "<leader>wn" (cmd "tabnext") "Next tab")
    (nmap "<leader>wp" (cmd "tabprevious") "Previous tab")
  ]
  # Cursor / window focus / window resize per direction
  ++ lib.mapAttrsToList (d: k: map [ "n" "v" ] k motion.${d} null) dir
  ++ lib.mapAttrsToList (d: k: nmap "<${moveMod}-${k}>" "<C-w>${vimDir.${d}}" "Go to ${d} window") dir
  ++ lib.mapAttrsToList (d: k: nmap "<${resizeMod}-${k}>" (cmd resize.${d}) "Resize window ${d}") dir;
}
