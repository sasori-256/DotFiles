{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreDups = true;
    history.ignoreSpace = true;

    plugins = [
      {
        name = "zsh-abbr";
        src = "${pkgs.zsh-abbr}/share/zsh/zsh-abbr";
      }
    ];

    sessionVariables = {
      "EDITOR" = "nvim";
      "VISUAL" = "nvim";
      "MANPAGER" = "sh -c 'col -bx | bat -l man -p'";
      "PROTO_HOME" = "$HOME/.proto";
    };

    initContent = lib.mkMerge [
      # ------------------------------------------------------------
      # Order 1000: Normal User Environment
      # ------------------------------------------------------------
      (lib.mkOrder 1000 ''
        # --- 1Password SSH Agent ---
        export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

        # --- Proto Environment ---
        export PATH="$PROTO_HOME/shims:PROTO_HOME/bin:$PATH"
        if command -v proto >/dev/null 2>&1; then
          eval "$(proto activate zsh)"
        fi

        # --- Functions ---
        function vf() { nvim "$(fzf)" }
        function cf() { bat "$(fzf)" }
      '')
      # # --- FZF Key Bindings ---
      # source "${pkgs.fzf}/share/fzf/key-bindings.zsh"

      # ------------------------------------------------------------
      # Order 1200: After init of zsh plugins and shell
      # ------------------------------------------------------------
      (lib.mkOrder 1200 ''
        # --- Abbreviations ---
        abbr -S -q g=git
        abbr -S -q ga="git add"
        abbr -S -q gc="git commit"
        abbr -S -q gp="git push"
        abbr -S -q gst="git status"
        abbr -S -q gd="git diff"
        abbr -S -q lg=lazygit
        abbr -S -q v=nvim
        abbr -S -q -f cat=bat
        abbr -S -q -f cd=z
        abbr -S -q ..="z .."
        abbr -S -q ...="z ../.."
        abbr -S -q -f ls="eza --icons --group-directories-first"
        abbr -S -q ll="eza -la --icons --git --group-directories-first"
        abbr -S -q lt="eza -la --icons --git --group-directories-first -T -L 2"
      '')

      # ------------------------------------------------------------
      # Order 1500: Tail of .zshrc, after all other initContent
      # ------------------------------------------------------------
      (lib.mkOrder 1500 ''
        # --- Welcome Message ---
        fastfetch
      '')
    ];
    # initExtra = ''
    # '';
  };
}
