{ lib }:

rec {
  # Tomisuke layout keys at the h/j/k/l positions
  dir = {
    left = "n";
    down = "t";
    up = "s";
    right = "k";
  };

  # Vim's own direction keys, for <C-w> commands
  vimDir = {
    left = "h";
    down = "j";
    up = "k";
    right = "l";
  };

  map = mode: key: action: desc: {
    inherit mode key action;
    options = {
      silent = true;
    }
    // lib.optionalAttrs (desc != null) { inherit desc; };
  };
  nmap = map "n";

  cmd = c: "<cmd>${c}<CR>";
  luaCmd = c: cmd "lua ${c}";
}
